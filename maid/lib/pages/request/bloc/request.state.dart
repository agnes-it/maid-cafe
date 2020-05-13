part of 'request.bloc.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestUninitialized extends RequestState {}

class RequestError extends RequestState {
  final String error;

  const RequestError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RequestFailure { error: $error }';
}

class RequestMenuUpdated extends RequestState {
  final RequestMenu requestMenu;

  const RequestMenuUpdated({
    this.requestMenu
  });

  RequestMenuUpdated copyWith({
    RequestMenu requestMenu
  }) {
    return RequestMenuUpdated(
      requestMenu: requestMenu ?? this.requestMenu
    );
  }

  @override
  List<Object> get props => [requestMenu];

  @override
  String toString() =>
      'RequestMenuUpdated { menu: ${requestMenu.menu}, amount: ${requestMenu.amount} }';
}

class RequestAdditionalInfoUpdated extends RequestState {
  final Request request;

  const RequestAdditionalInfoUpdated({
    this.request
  });

  RequestAdditionalInfoUpdated copyWith({
    Request request
  }) {
    return RequestAdditionalInfoUpdated(
      request: request ?? this.request
    );
  }

  @override
  List<Object> get props => [request];

  @override
  String toString() =>
      'RequestAdditionalInfoUpdated { id: ${request.id}, maid: ${request.maid}, order: ${request.order}, table: ${request.table} }';
}

class RequestCreated extends RequestState {
  final Request request;

  const RequestCreated({
    this.request
  });

  RequestCreated copyWith({
    Request request
  }) {
    return RequestCreated(
      request: request ?? this.request
    );
  }

  @override
  List<Object> get props => [request];

  @override
  String toString() =>
      'RequestCreated { id: ${request.id}, maid: ${request.maid}, order: ${request.order}, table: ${request.table} }';
}

class RequestLoaded extends RequestState {
  final Request request;

  const RequestLoaded({
    this.request
  });

  RequestLoaded copyWith({
    Request request
  }) {
    return RequestLoaded(
      request: request ?? this.request
    );
  }

  @override
  List<Object> get props => [request];

  @override
  String toString() =>
      'RequestLoaded { id: ${request.id}, maid: ${request.maid}, order: ${request.order}, table: ${request.table} }';
}