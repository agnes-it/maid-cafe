import 'package:equatable/equatable.dart';
import 'package:maid/pages/request/models/request_menu.dart';


class Request extends Equatable {
  final int id;
  final int order;
  final String maid;
  final String table;
  final List<RequestMenu> menus;
  final String additionalInfo;

  const Request({this.id, this.maid, this.table, this.menus, this.order, this.additionalInfo});

  @override
  List<Object> get props => [id, maid, table, menus, order, additionalInfo];

  @override
  String toString() => 'Menu { id: $id }';
}
