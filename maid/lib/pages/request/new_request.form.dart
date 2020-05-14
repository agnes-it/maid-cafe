import 'package:flutter/material.dart';

import 'package:maid/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/pages/request/bloc/menu.bloc.dart';
import 'package:maid/pages/request/bloc/request.bloc.dart';
import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';
import 'package:maid/pages/request/bloc/request.service.dart';
import 'package:maid/pages/request/models/menu.dart';
import 'package:maid/pages/request/models/request_menu.dart';
import 'package:maid/pages/request/request_menu.component.dart';

class RequestForm extends StatefulWidget {
  final MenuService menuRepository;
  final AuthService userRepository;
  final RequestService requestRepository;
  final int orderId;
  final String tableName;

  RequestForm({
    Key key,
    @required this.requestRepository,
    @required this.menuRepository,
    @required this.userRepository,
    @required this.orderId,
    @required this.tableName
    })
      : assert(menuRepository != null, userRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => new _RequestPageState();
}

class _RequestPageState extends State<RequestForm> {
  List<Menu> entries = [];
  RequestBloc _requestBloc;

  @override
  Widget build(BuildContext context) {
    _requestBloc = BlocProvider.of<RequestBloc>(context);
    return BlocListener<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is MenuLoaded) {
          entries = state.menus;
          _requestBloc.add(New(order: widget.orderId, table: widget.tableName));
        }

        if (state is MenuError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          return new Container(
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
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, int index) {
    return BlocProvider(
      create: (context) => RequestBloc(
        menuRepository: widget.menuRepository,
        userRepository: widget.userRepository,
        requestRepository: widget.requestRepository
      )..add(New(order: widget.orderId, table: widget.tableName)),
      child: RequestMenuInput(
        menu: entries[index],
        menuRepository: widget.menuRepository,
        userRepository: widget.userRepository,
      )
    );
  } 
}