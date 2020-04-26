import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/pages/home.page.dart';
import 'package:maid/pages/login/login.page.dart';
import 'package:maid/pages/new_order.page.dart';
import 'package:maid/pages/request/new_request.page.dart';
import 'package:maid/pages/request_review.page.dart';
import 'package:maid/pages/splash.page.dart';
import 'package:maid/auth/auth.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = AuthService();
  final menuRepository = MenuService();
  
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository, menuRepository: menuRepository),
    ),
  );
}

class App extends StatelessWidget {
  final AuthService userRepository;
  final MenuService menuRepository;

  App({Key key, @required this.userRepository, @required this.menuRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maid Cafe',
      theme: new ThemeData(
        primarySwatch: Colors.red
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return HomePage(userRepository: userRepository);
          }
          if (state is AuthUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          return SplashPage();
        },
      ),
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/home': (BuildContext context) => new HomePage(userRepository: userRepository),
        '/login': (BuildContext context) => new LoginPage(userRepository: userRepository),
        '/new_order': (BuildContext context) => new OrderPage(),
        '/new_request': (BuildContext context) => new RequestPage(userRepository: userRepository, menuRepository: menuRepository),
        '/request_review': (BuildContext context) => new RequestReviewPage(),
      },
    );
  }
}