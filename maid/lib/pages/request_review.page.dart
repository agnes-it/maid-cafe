import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';
import 'package:maid/pages/request/bloc/request.bloc.dart';
import 'package:maid/pages/request/bloc/request.service.dart';
import 'package:maid/pages/request/models/request.dart';
import 'package:maid/pages/request/request.arguments.dart';

class RequestReviewPage extends StatefulWidget {
  final MenuService menuRepository;
  final AuthService userRepository;
  final requestRepository = RequestService();
  
  RequestReviewPage({
    Key key,
    @required this.menuRepository,
    @required this.userRepository
  })
    : assert(menuRepository != null, userRepository != null),
      super(key: key);

  @override
  State<StatefulWidget> createState() => new _ReviewRequestPageState();
}

class _ReviewRequestPageState extends State<RequestReviewPage> {
  final requestRepository = RequestService();
  final List<int> colorCodes = <int>[600, 500, 100];
  Request request;
  
  @override
  Widget build(BuildContext context) {
    final RequestArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (context) => RequestBloc(
        menuRepository: widget.menuRepository,
        userRepository: widget.userRepository,
        requestRepository: requestRepository
      )..add(New(order: args.orderId, table: args.tableName)),
      child: BlocListener<RequestBloc, RequestState>(
          listener: (context, state) {
            if (state is RequestLoaded) {
              print(state.request.menus);
              request = state.request;
            }
            if (state is RequestCreated) {
                Navigator.pushNamed(context, '/home');
              } 
            },
            child: BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                if (state is RequestUninitialized) {
                  return CircularProgressIndicator();
                }
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
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.table_chart),
                            title: Text(request.table),
                            subtitle: Text(request.maid),
                          ),
                          Expanded(
                            child:
                              ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: request.menus.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 50,
                                    color: Colors.amber[colorCodes[index]],
                                    child: Center(child: Text('x${request.menus[index].amount} ${request.menus[index].item}')),
                                  );
                                }
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            )
          )
    );
  }
}