import 'package:maid/main.dart';
import 'package:flutter/material.dart';

class RequestReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Request Review'),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/home');
      },
      child: Icon(Icons.send),
      backgroundColor: Colors.red,
    ),
    body: new Container(
      alignment: Alignment.center,
      child: Text('request review')
    ),
  );
}