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
    final String maid = await userRepository.getUsername();

    if (event is New) {
      try {
        if (currentState is RequestUninitialized) {
          Request request;
          if (requestRepository.hasRequest(event.order)) {
            request = requestRepository.getRequest(event.order);
          } else {
            request = requestRepository.of(maid, event.order, event.table, []);
          }
          yield RequestLoaded(request: request);
          return;
        }
        if (currentState is RequestLoaded) {
          Request request;
          if (requestRepository.hasRequest(event.order)) {
            request = requestRepository.getRequest(event.order);
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

    if (event is Create) {
      //try {
        if (currentState is RequestLoaded) {
          Request request;
          if (requestRepository.hasRequest(event.order)) {
            request = requestRepository.getRequest(event.order);
          } else {
            yield RequestError(error: "Cannot find request in storage");
            return;
          }
          final String token = await userRepository.getToken();
          request = await requestRepository.create(token, request);
          requestRepository.removeRequest(event.order);
          yield RequestCreated(request: request);
          return;
        }
      //} catch (error) {
      //  yield RequestError(error: error.toString());
      //}
    }

    if (event is UpdateRequestMenu) {
      try {
        if (currentState is RequestUninitialized) {
          yield RequestError(error: "Cannot update request menu without creating a request");
          return;
        }
        if (currentState is RequestLoaded || currentState is RequestMenuUpdated || currentState is RequestAdditionalInfoUpdated) {
          final requestMenu = requestRepository.requestMenu(event.item, event.menu, event.amount);
          requestRepository.persistRequest(requestRepository.request);
          yield RequestMenuUpdated(requestMenu: requestMenu);
          return;
        }
      } catch (error) {
        yield RequestError(error: error.toString());
      }
    }

    if (event is UpdateAdditionalInfo) {
      try {
        if (currentState is RequestUninitialized) {
          yield RequestError(error: "Cannot update request menu without creating a request");
          return;
        }
        if (currentState is RequestMenuUpdated || currentState is RequestAdditionalInfoUpdated) {
          final request = requestRepository.updateAdditionalInfo(event.additionalInfo);
          requestRepository.persistRequest(request);
          yield RequestAdditionalInfoUpdated(request: request);
          return;
        }
      } catch (error) {
        yield RequestError(error: error.toString());
      }
    }
  }
}