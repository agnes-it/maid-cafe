import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/pages/order/home.page.dart';
import 'package:maid/pages/login/login.page.dart';
import 'package:maid/pages/new_order.page.dart';
import 'package:maid/pages/request/new_request.page.dart';
import 'package:maid/pages/request_review.page.dart';
import 'package:maid/pages/splash.page.dart';
import 'package:maid/auth/auth.dart';
import 'package:maid/pages/order/bloc/order.service.dart';
import 'package:maid/pages/order/bloc/order.bloc.dart';
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
  final orderRepository = OrderService();

  final withAuth = BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    );

  
  runApp(
    BlocProvider<OrderBloc>(
      create: (context) => OrderBloc(
            orderRepository: orderRepository,
            userRepository: userRepository,
          )..add(Fetch()),
      child: withAuth,
    ),
  );
}

class App extends StatelessWidget {
  final AuthService userRepository;
  final MenuService menuRepository = MenuService();
  final orderRepository = OrderService();

  App({Key key, @required this.userRepository}) : super(key: key);

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
            return HomePage(userRepository: userRepository, orderRepository: orderRepository);
          }
          if (state is AuthUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          return SplashPage();
        },
      ),
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/home': (BuildContext context) => new HomePage(userRepository: userRepository, orderRepository: orderRepository),
        '/login': (BuildContext context) => new LoginPage(userRepository: userRepository),
        '/new_order': (BuildContext context) => new OrderPage(userRepository: userRepository, orderRepository: orderRepository),
        '/new_request': (BuildContext context) => new RequestPage(userRepository: userRepository, menuRepository: menuRepository),
        '/request_review': (BuildContext context) => new RequestReviewPage(userRepository: userRepository, menuRepository: menuRepository),
      },
    );
  }
}