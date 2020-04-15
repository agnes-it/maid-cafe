import 'package:maid/pages/home.page.dart';
import 'package:maid/pages/login.page.dart';
import 'package:maid/services/auth.service.dart';
import 'package:flutter/material.dart';

AuthService appAuth = new AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set default home.
  Widget _defaultHome = new LoginPage();

  // Get result of the login function.
  bool _result = await appAuth.authenticated();
  if (_result) {
    _defaultHome = new HomePage();
  }

  // Run app!
  runApp(new MaterialApp(
    title: 'Maid Cafe',
    theme: new ThemeData(
      primarySwatch: Colors.red
    ),
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage()
    },
  ));
}