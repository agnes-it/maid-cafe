import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';
import 'package:maid/pages/request/bloc/request.bloc.dart';
import 'package:maid/pages/request/bloc/request.service.dart';
import 'package:maid/pages/request/models/request.dart';
import 'package:maid/pages/request/request.arguments.dart';

class RequestReviewPage extends StatelessWidget {
  final MenuService menuRepository;
  final AuthService userRepository;
  final requestRepository = RequestService();
  Request request;

  RequestReviewPage({Key key, @required this.menuRepository, @required this.userRepository})
      : assert(menuRepository != null, userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final RequestArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (context) => RequestBloc(
        menuRepository: menuRepository,
        userRepository: userRepository,
        requestRepository: requestRepository
      )..add(New(order: args.orderId, table: args.tableName)),
      child: BlocListener<RequestBloc, RequestState>(
          listener: (context, state) {
            if (state is RequestLoaded) {
              request = state.request;
            }
            if (state is RequestCreated) {
                Navigator.pushNamed(context, '/home');
              } 
            },
            child: BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                return new Scaffold(
                  appBar: new AppBar(
                    title: new Text('Request Review'),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<RequestBloc>(context).add(Create(order: args.orderId, table: args.tableName));
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
            )
          )
    );
  }
}