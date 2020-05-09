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

  Request.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        order = json['order'],
        maid = json['maid'],
        table = json['table'],
        menus = List.from(json['menus']).map((requestMenu) => RequestMenu.fromJson(requestMenu)),
        additionalInfo = json['additionalInfo'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'order': order,
      'maid': maid,
      'table': table,
      'menus': menus.map((requestMenu) => requestMenu.toJson()),
      'additionalInfo': additionalInfo,
    };

  RequestMenu appendMenu(int menu, int amount) {
    RequestMenu requestMenu = new RequestMenu(menu: menu, amount: amount);
    menus.add(requestMenu);
    return requestMenu;
  }
}
