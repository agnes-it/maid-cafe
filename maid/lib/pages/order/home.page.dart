import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/pages/order/models/order.dart';
import 'package:maid/pages/order/bloc/order.service.dart';
import 'package:maid/pages/order/bloc/order.bloc.dart';
import 'package:maid/auth/auth.dart';

class HomePage extends StatelessWidget {
  final AuthService userRepository;
  final OrderService orderRepository;
  List<Order> entries = [];

   HomePage({Key key, @required this.userRepository, @required this.orderRepository})
      : assert(userRepository != null, orderRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Maid Cafe'),
    ),
    drawer: Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              userRepository.logout().then(
                  (_) => {
                    BlocProvider.of<AuthBloc>(context).add(LoggedOut())
                  }
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/new_order');
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
    ),
    body: BlocProvider(
      create: (context) => OrderBloc(
            orderRepository: orderRepository,
            userRepository: userRepository,
          )..add(Fetch()),
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderLoaded) {
            entries = state.orders;
          }

          if (state is OrderError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return new Container(
              alignment: Alignment.center,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(entries.length, (index) {
                  return _buildList(context, entries[index], index);
                }),
              ),
            );
          }),
        ),
      ),
    );

  Widget _buildList(BuildContext context, Order order, int index) {
    return new GestureDetector(
      onTap: (){
        print("Container clicked");
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
            left: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
            right: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
            bottom: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
          ),
          color: Color(0xFFFBE9E7),
        ),
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('images/table-icon.png'), width: 75, height: 75),
              Text(
                order.table,
                style: Theme.of(context).textTheme.headline,
              ),
            ]
          ),
        ),
      )
    );
  }
}