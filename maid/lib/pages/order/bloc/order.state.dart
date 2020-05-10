part of 'order.bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderUninitialized extends OrderState {}

class OrderError extends OrderState {
  final String error;

  const OrderError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OrderFailure { error: $error }';
}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  const OrderLoaded({
    this.orders
  });

  OrderLoaded copyWith({
    List<Order> orders
  }) {
    return OrderLoaded(
      orders: orders ?? this.orders
    );
  }

  @override
  List<Object> get props => [orders];

  @override
  String toString() =>
      'OrderLoaded { orders: ${orders.length} }';
}