import 'package:equatable/equatable.dart';
import 'package:maid/pages/request/models/request_menu.dart';


class Request extends Equatable {
  final int id;
  final int order;
  final String maid;
  final String table;
  final List<RequestMenu> menus;
  String additionalInfo;
  String client = '';

  String get info {
    return additionalInfo;
  }

  void set info(String _additionalInfo) {
    additionalInfo = _additionalInfo;
  }

  Request({this.id, this.maid, this.table, this.client, this.menus, this.order, this.additionalInfo});

  @override
  List<Object> get props => [id, maid, table, client, menus, order, additionalInfo];

  @override
  String toString() => 'Request { id: $id, order: $order }';

  Request.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        order = json['order'],
        maid = json['maid'],
        table = json['table'],
        client = json['client'] ?? '',
        menus = List.from(json['menus']).map((requestMenu) => RequestMenu.fromJson(requestMenu)).toList(),
        additionalInfo = json['additionalInfo'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'order': order,
      'maid': maid,
      'table': table,
      'client': client,
      'menus': menus.map((requestMenu) => requestMenu.toJson()).toList(),
      'additionalInfo': additionalInfo,
    };

  RequestMenu appendMenu(int menu, String item, int amount) {
    RequestMenu requestMenu = new RequestMenu(menu: menu, item: item, amount: amount);
    menus.add(requestMenu);
    return requestMenu;
  }
}
