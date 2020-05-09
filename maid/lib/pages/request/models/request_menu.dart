import 'package:equatable/equatable.dart';

class RequestMenu extends Equatable {
  final int menu;
  final int amount;

  const RequestMenu({this.menu, this.amount});

  @override
  List<Object> get props => [menu, amount];

  @override
  String toString() => 'RequestMenu { menu: $menu, amount: $amount }';

  RequestMenu.fromJson(Map<String, dynamic> json)
      : menu = json['menu'],
        amount = json['amount'];

  Map<String, dynamic> toJson() =>
    {
      'menu': menu,
      'amount': amount,
    };
}