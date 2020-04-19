import 'package:maid/main.dart';
import 'package:maid/components/flutter_counter.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final List<String> entries = <String>['Sopa Gostosa', 'Hamburgao', 'Pa de coentro'];
  final List<int> colorCodes = <int>[600, 500, 100];
  int _defaultValue = 0;
  var _itemsValues = new Map();

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
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: Text('${entries[index]}'),
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
                    });
                  },
                ),
              ],
            )
          );
        }
      ),
    ),
  );
}