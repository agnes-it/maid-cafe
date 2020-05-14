part of 'table.bloc.dart';

abstract class TableEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends TableEvent {}