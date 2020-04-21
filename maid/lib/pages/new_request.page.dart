import 'package:maid/main.dart';
import 'package:maid/components/flutter_counter.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final List<String> entries = <String>['Sopa Gostosa', 'Hamburgao', 'Pa de coentro'];
  int _defaultValue = 0;
  var _itemsValues = new Map();
  final _additionalInfoFilter = TextEditingController();
  String _additionalInfo = "";

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
                initialValue: _itemsValues[index] ?? 0,
                minValue: 0,
                maxValue: 10,
                step: 1,
                herotag: '${index}',
                decimalPlaces: 0,
                onChanged: (value) {
                  setState(() {
                    _defaultValue = value;
                    _itemsValues[index] = value;
                    _updateFieldControllers();
                  });
                },
              ),
            ],
          )
        ),
        _buildAdditionalInfo(_itemsValues[index])
      ]
    );
  }

  Widget _buildAdditionalInfo(amount) {
    int amountValue = amount ?? 0;
    print(amountValue);
    if (amountValue > 0) {
      return new Container(
        child: new TextField(
          controller: _additionalInfoFilter,
          decoration: new InputDecoration(
            labelText: 'additional info',
            contentPadding: const EdgeInsets.all(10.0),
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: Icon(Icons.announcement),
          ),
        ),
      );
    } else {
      return new Container();
    }
  }

  void _updateFieldControllers() {
    print(_itemsValues.length);
  }
}