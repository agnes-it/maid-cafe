import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/bloc/menu.bloc.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';
//import 'package:maid/pages/request/bloc/request.dart';
import 'package:maid/pages/request/new_request.form.dart';


class RequestPage extends StatelessWidget {
  final MenuService menuRepository;
  final AuthService userRepository;

  RequestPage({Key key, @required this.menuRepository, @required this.userRepository})
      : assert(menuRepository != null, userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Request'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/request_review');
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.red,
      ),
      body: BlocProvider(
        create: (context) =>
          MenuBloc(
            //requestBloc: BlocProvider.of<RequestBloc>(context),
            menuRepository: menuRepository,
            userRepository: userRepository,
          )..add(Fetch()),
        child: RequestForm(),
      ),
    );
  }
}