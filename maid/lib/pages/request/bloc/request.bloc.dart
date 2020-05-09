import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/models/request.dart';
import 'package:maid/pages/request/models/request_menu.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';
import 'package:maid/pages/request/bloc/request.service.dart';

part 'request.event.dart';
part 'request.state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final MenuService menuRepository;
  final AuthService userRepository;
  final RequestService requestRepository;

  RequestBloc({
    @required this.menuRepository,
    @required this.userRepository,
    @required this.requestRepository,
  })  : assert(menuRepository != null,
  userRepository != null);

  @override
  get initialState => RequestUninitialized();

  @override
  Stream<RequestState> mapEventToState(RequestEvent event) async* {
    final currentState = state;
    if (event is New) {
      try {
        final String maid = await userRepository.getUsername();
        if (currentState is RequestUninitialized) {
          Request request;
          if (await requestRepository.hasRequest(event.order)) {
            request = await requestRepository.getRequest(event.order);
          } else {
            request = requestRepository.of(maid, event.order, event.table, []);
          }
          yield RequestLoaded(request: request);
          return;
        }
        if (currentState is RequestLoaded) {
          Request request;
          if (await requestRepository.hasRequest(event.order)) {
            request = await requestRepository.getRequest(event.order);
          } else {
            request = requestRepository.of(maid, event.order, event.table, []);
          }
          yield RequestLoaded(request: request);
          return;
        }
      } catch (error) {
        yield RequestError(error: error.toString());
      }
    }

    if (event is UpdateRequestMenu) {
      try {
        if (currentState is RequestUninitialized) {
          yield RequestError(error: "Cannot update request menu without creating a request");
          return;
        }
        if (currentState is RequestLoaded || currentState is RequestMenuUpdated) {
          final requestMenu = requestRepository.requestMenu(event.menu, event.amount);
          yield RequestMenuUpdated(requestMenu: requestMenu);
          return;
        }
      } catch (error) {
        yield RequestError(error: error.toString());
      }
    }
  }
}