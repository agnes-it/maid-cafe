part of 'order.bloc.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends OrderEvent {}

class Create extends OrderEvent {
  final String customer;
  final String table;
  
  Create({
    this.customer,
    @required this.table,
  })  : assert(
              table != null);
}