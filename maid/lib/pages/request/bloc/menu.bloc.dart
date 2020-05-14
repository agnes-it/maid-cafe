import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/models/menu.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';

part 'menu.event.dart';
part 'menu.state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuService menuRepository;
  final AuthService userRepository;

  MenuBloc({
    @required this.menuRepository,
    @required this.userRepository,
  })  : assert(menuRepository != null,
  userRepository != null);

  @override
  get initialState => MenuUninitialized();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    final currentState = state;
    if (event is Fetch) {
      try {
        final token = await userRepository.getToken();
        if (currentState is MenuUninitialized) {
          final menus = await menuRepository.list(token);
          yield MenuLoaded(menus: menus);
          return;
        }
        if (currentState is MenuLoaded) {
          final menus = await menuRepository.list(token);
          yield menus.isEmpty
              ? currentState.copyWith()
              : MenuLoaded(
                  menus: menus,
                );
        }
      } catch (error) {
        yield MenuError(error: error.toString());
      }
    }
  }
}