import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final String client;
  final String table;
  
  const Order({this.id, this.client, this.table});

  @override
  List<Object> get props => [id, client, table];

  @override
  String toString() => 'Order { id: $id, client: $client, table: $table }';

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        client = json['client'],
        table = json['table'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'client': client,
      'table': table,
    };

}
