part of 'request.bloc.dart';

abstract class RequestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateRequestMenu extends RequestEvent {
  final int menu;
  final int amount;
  
  UpdateRequestMenu({
    @required this.menu,
    @required this.amount,
  })  : assert(menu != null,
              amount != null);
}

class UpdateAdditionalInfo extends RequestEvent {
  final String additionalInfo;
  
  UpdateAdditionalInfo({
    @required this.additionalInfo,
  })  : assert(additionalInfo != null);
}

class New extends RequestEvent {
  final int order;
  final String table;
  
  New({
    @required this.order,
    @required this.table,
  })  : assert(
              order != null);
}

class Create extends RequestEvent {
  final int order;
  final String table;
  
  Create({
    @required this.order,
    @required this.table,
  })  : assert(
              order != null);
}