part of 'menu.bloc.dart';

abstract class MenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends MenuEvent {}