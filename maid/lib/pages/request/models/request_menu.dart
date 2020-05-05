import 'package:equatable/equatable.dart';

class RequestMenu extends Equatable {
  final int menu;
  final int amount;
  final String additionalInfo;

  const RequestMenu({this.menu, this.amount, this.additionalInfo});

  @override
  List<Object> get props => [menu, amount, additionalInfo];

  @override
  String toString() => 'RequestMenu { menu: $menu, amount: $amount }';
}