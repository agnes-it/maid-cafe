import 'package:maid/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/pages/order/bloc/order.service.dart';
import 'package:maid/pages/order/bloc/order.bloc.dart';
import 'package:maid/auth/auth.dart';
import 'package:maid/pages/order/models/table.dart' as tableModel;
import 'package:maid/pages/request/request.arguments.dart';

import 'order/bloc/table.bloc.dart' as tableBloc;
import 'order/bloc/table.service.dart';

class OrderPage extends StatefulWidget {
  final AuthService userRepository;
  final OrderService orderRepository;

  OrderPage({Key key, @required this.orderRepository, @required this.userRepository})
      : assert(orderRepository != null, userRepository != null),
        super(key: key);

  @override
  State<OrderPage> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderPage> {
  final tableRepository = TableService();
  final _customerController = TextEditingController();
  String dropdownValue;
  List<tableModel.Table> tables = [];
  
  @override
  Widget build(BuildContext context) {
    final _parentOrderBloc = BlocProvider.of<OrderBloc>(context);
    return BlocProvider(
      create: (context) => OrderBloc(
        orderRepository: widget.orderRepository,
        userRepository: widget.userRepository,
      ),
      child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
          if (state is OrderCreated) {
              _parentOrderBloc.add(Fetch());
              Navigator.of(context).pushReplacementNamed('/new_request', arguments: RequestArguments(
                state.order.id,
                state.order.table,
              ));
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return new Scaffold(
                appBar: new AppBar(
                  title: new Text('New Order'),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<OrderBloc>(context).add(Create(customer: this._customerController.text, table: this.dropdownValue));
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.red,
                ),
                body: 
                  BlocProvider(
                    create: (context) => tableBloc.TableBloc(
                      tableRepository: tableRepository,
                      userRepository: widget.userRepository,
                    )..add(tableBloc.Fetch()),
                    child: BlocListener<tableBloc.TableBloc, tableBloc.TableState>(
                      listener: (context, state) {
                      if (state is tableBloc.TableLoaded) {
                          tables = state.tables;
                        }
                      },
                      child: BlocBuilder<tableBloc.TableBloc, tableBloc.TableState>(
                        builder: (context, state) {
                          return Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(labelText: 'customer'),
                                  controller: _customerController,
                                ),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: tables.map((table) => table.label)
                                          .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                ),
                                Container(
                                  child: state is OrderLoading
                                      ? CircularProgressIndicator()
                                      : null,
                                ),
                              ],
                            ),
                          );
                        }
                      )
                    )
                  )
                );
            }
          ),
        ),
      );
  }
}