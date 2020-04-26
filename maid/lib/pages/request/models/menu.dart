import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final int id;
  final String item;
  final String description;
  final String price;
  final bool available;

  const Menu({this.id, this.item, this.description, this.price, this.available});

  @override
  List<Object> get props => [id, item, description, price, available];

  @override
  String toString() => 'Menu { id: $id }';
}
