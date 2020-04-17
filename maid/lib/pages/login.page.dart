import 'package:maid/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _status = '';
  String _username = "";
  String _password = "";
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();

  _LoginPageState() {
    _usernameFilter.addListener(_usernameListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _usernameListen() {
    if (_usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = _usernameFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Login'),
    ),
    body: Builder(
      builder: (BuildContext context) {
        return new Container(
          padding: EdgeInsets.all(16.0),
          child: new Center(
            child: 
            new Column(
              children: <Widget>[
                _buildTextFields(),
                new RaisedButton(
                  child: new Text(
                    'Login'
                  ),
                  onPressed: () {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Logging...'),
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      );
                    appAuth.login(_username, _password).then((result) {
                      if (result.isNotEmpty) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        Scaffold.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Login failure, please try again.'),
                                  Icon(Icons.error),
                                ],
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                      }
                    });
                  }
                ),
              ],
            ),
          ),
        );
      }
    )   
  );

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _usernameFilter,
              decoration: new InputDecoration(
                labelText: 'username'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }
}