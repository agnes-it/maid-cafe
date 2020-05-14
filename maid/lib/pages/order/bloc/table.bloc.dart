import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/order/models/table.dart';
import 'package:maid/pages/order/bloc/table.service.dart';

part 'table.event.dart';
part 'table.state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final TableService tableRepository;
  final AuthService userRepository;

  TableBloc({
    @required this.tableRepository,
    @required this.userRepository,
  })  : assert(tableRepository != null,
  userRepository != null);

  @override
  get initialState => TableUninitialized();

  @override
  Stream<TableState> mapEventToState(TableEvent event) async* {
    final currentState = state;
    if (event is Fetch) {
      try {
        final token = await userRepository.getToken();
        if (currentState is TableUninitialized) {
          final tables = await tableRepository.list(token);
          yield TableLoaded(tables: tables);
          return;
        }
        if (currentState is TableLoaded) {
          final tables = await tableRepository.list(token);
          yield tables.isEmpty
              ? currentState.copyWith()
              : TableLoaded(
                  tables: tables,
                );
        }
      } catch (error) {
        yield TableError(error: error.toString());
      }
    }
  }
}