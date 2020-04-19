import 'package:maid/pages/home.page.dart';
import 'package:maid/pages/login.page.dart';
import 'package:maid/pages/new_order.page.dart';
import 'package:maid/pages/new_request.page.dart';
import 'package:maid/pages/request_review.page.dart';
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
      '/login': (BuildContext context) => new LoginPage(),
      '/new_order': (BuildContext context) => new OrderPage(),
      '/new_request': (BuildContext context) => new RequestPage(),
      '/request_review': (BuildContext context) => new RequestReviewPage(),
    },
  ));
}