import 'package:equatable/equatable.dart';

class RequestMenu extends Equatable {
  final int menu;
  final String item;
  final int amount;

  const RequestMenu({this.menu, this.item, this.amount});

  @override
  List<Object> get props => [menu, item, amount];

  @override
  String toString() => 'RequestMenu { menu: $menu, item: $item, amount: $amount }';

  RequestMenu.fromJson(Map<String, dynamic> json)
      : menu = json['menu'],
        item = json['item'],
        amount = json['amount'];

  Map<String, dynamic> toJson() =>
    {
      'menu': menu,
      'item': item,
      'amount': amount,
    };
}