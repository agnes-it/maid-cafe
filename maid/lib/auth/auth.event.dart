import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;
  final String username;

  const LoggedIn({@required this.username, @required this.token});

  @override
  List<Object> get props => [username, token];

  @override
  String toString() => 'LoggedIn { username: $username, token: $token }';
}

class LoggedOut extends AuthEvent {}