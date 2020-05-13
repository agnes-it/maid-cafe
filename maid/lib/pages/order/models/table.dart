import 'package:equatable/equatable.dart';

class Table extends Equatable {
  final int id;
  final int number;
  final String label;
  
  const Table({this.id, this.number, this.label});

  @override
  List<Object> get props => [id, number, label];

  @override
  String toString() => 'Table { id: $id, number: $number, label: $label }';

  Table.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        number = json['number'],
        label = json['label'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'number': number,
      'label': label,
    };

}
