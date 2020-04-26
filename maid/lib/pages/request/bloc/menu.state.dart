part of 'menu.bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuUninitialized extends MenuState {}

class MenuError extends MenuState {
  final String error;

  const MenuError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MenuFailure { error: $error }';
}

class MenuLoaded extends MenuState {
  final List<Menu> menus;

  const MenuLoaded({
    this.menus
  });

  MenuLoaded copyWith({
    List<Menu> menus
  }) {
    return MenuLoaded(
      menus: menus ?? this.menus
    );
  }

  @override
  List<Object> get props => [menus];

  @override
  String toString() =>
      'MenuLoaded { menus: ${menus.length} }';
}