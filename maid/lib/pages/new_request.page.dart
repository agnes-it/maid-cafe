import 'package:maid/main.dart';
import 'package:maid/components/flutter_counter.dart';
import 'package:maid/helpers.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final List<String> entries = <String>['Sopa Gostosa', 'Hamburgao', 'Pa de coentro', 'Arroz Doce', 'Pao de alho', 'Comida caseira', 'jilo frito'];
  int _defaultValue = 0;
  var _itemsValues = new Map();
  Map<String,TextEditingController> _additionalInfoFilters = {};

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('New Request'),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/request_review');
      },
      child: Icon(Icons.send),
      backgroundColor: Colors.red,
    ),
    body: new Container(
      alignment: Alignment.center,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) => _buildList(context, index),
        separatorBuilder: (BuildContext context, int index) => new Divider(
          height: 50.0,
          color: Colors.grey[400],
        ),
      ),
    ),
  );

  Widget _buildList(BuildContext context, int index) {
    String id = strToHash(entries[index]);
    return Column(
      children: [
        new Container(
          height: 70.0,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${entries[index]}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Counter(
                initialValue: _itemsValues[id] ?? 0,
                minValue: 0,
                maxValue: 10,
                step: 1,
                herotag: '${index}',
                decimalPlaces: 0,
                onChanged: (value) {
                  setState(() {
                    _defaultValue = value;
                    _itemsValues[id] = value;
                    _updateFieldControllers(id);
                  });
                },
              ),
            ],
          )
        ),
        ..._buildAdditionalInfo(_itemsValues[id], entries[index])
      ]
    );
  }

  _buildAdditionalInfo(amount, menuName) {
    int amountValue = amount ?? 0;
    String id = '${menuName}';
    if (amountValue > 0) {
      return List<Widget>.generate(
        amountValue,
        (i) => TextField(
            controller: _additionalInfoFilters[id],
            decoration: new InputDecoration(
              labelText: '${i + 1} additional info',
              contentPadding: const EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: Icon(Icons.announcement),
            ),
          )
      );
    } else {
      return [];
    }
  }

  void generateControllers(item, index) {
    int amount = _itemsValues[item];
    for (var i = 0; i <= amount; i += 1) {
      String id = '${item}${i.toString()}';
      if (_additionalInfoFilters[id] == null) {
        _additionalInfoFilters[id] = new TextEditingController();
      }
    }
  }

  void _updateFieldControllers(id) {
    _itemsValues.forEach(generateControllers);
  }
}