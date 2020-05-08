import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:maid/auth/auth.dart';

class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  final AuthService userRepository;

  AuthBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.authenticated();

      if (hasToken) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      await userRepository.persistUsername(event.username);
      await userRepository.persistToken(event.token);
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await userRepository.deleteUsername();
      await userRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}