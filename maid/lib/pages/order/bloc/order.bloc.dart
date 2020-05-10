import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/order/models/order.dart';
import 'package:maid/pages/order/bloc/order.service.dart';

part 'order.event.dart';
part 'order.state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderService orderRepository;
  final AuthService userRepository;

  OrderBloc({
    @required this.orderRepository,
    @required this.userRepository,
  })  : assert(orderRepository != null,
  userRepository != null);

  @override
  get initialState => OrderUninitialized();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    final currentState = state;
    if (event is Fetch) {
      try {
        final token = await userRepository.getToken();
        if (currentState is OrderUninitialized) {
          final orders = await orderRepository.list(token);
          yield OrderLoaded(orders: orders);
          return;
        }
        if (currentState is OrderLoaded) {
          final orders = await orderRepository.list(token);
          yield orders.isEmpty
              ? currentState.copyWith()
              : OrderLoaded(
                  orders: orders,
                );
        }
      } catch (error) {
        yield OrderError(error: error.toString());
      }
    }
  }
}