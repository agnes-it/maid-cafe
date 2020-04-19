import 'package:maid/main.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('New Order'),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/new_request');
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
    ),
    body: new Container(
      alignment: Alignment.center,
      child: Text('new order')
    ),
  );
}