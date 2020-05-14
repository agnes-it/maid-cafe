part of 'table.bloc.dart';

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableUninitialized extends TableState {}

class TableError extends TableState {
  final String error;

  const TableError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TableFailure { error: $error }';
}

class TableLoaded extends TableState {
  final List<Table> tables;

  const TableLoaded({
    this.tables
  });

  TableLoaded copyWith({
    List<Table> tables
  }) {
    return TableLoaded(
      tables: tables ?? this.tables
    );
  }

  @override
  List<Object> get props => [tables];

  @override
  String toString() =>
      'TableLoaded { tables: ${tables.length} }';
}

class TableLoading extends TableState {}