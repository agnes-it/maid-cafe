import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maid/components/flutter_counter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';
import 'package:maid/pages/request/models/menu.dart';
import 'package:maid/pages/request/models/request_menu.dart';
import 'package:maid/pages/request/bloc/request.bloc.dart';
import 'package:maid/debouncer.dart';

class RequestMenuInput extends StatefulWidget {
  final MenuService menuRepository;
  final AuthService userRepository;
  final Menu menu;

  RequestMenuInput({Key key, @required this.menu, @required this.menuRepository, @required this.userRepository})
      : assert(menuRepository != null, userRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => new _RequestMenuState();
}

class _RequestMenuState extends State<RequestMenuInput> {
  RequestMenu requestMenu;
  Map<String, TextEditingController> _additionalInfoFilters = {};
  Timer _debounce;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestBloc, RequestState>(
      listener: (context, state) {
        if (state is RequestMenuUpdated && state.requestMenu.menu == widget.menu.id) {
          if (state.requestMenu.amount == 0) {
            requestMenu = null;
            return;
          }
          requestMenu = state.requestMenu;
        }
      },
      child: BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state) {
          return new Column(
            children: [
              new Container(
                height: 70.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.menu.item}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Counter(
                      initialValue: requestMenu?.amount ?? 0,
                      minValue: 0,
                      maxValue: 10,
                      step: 1,
                      herotag: '${widget.menu.id}',
                      decimalPlaces: 0,
                      onChanged: (value) {
                        setState(() {
                          BlocProvider.of<RequestBloc>(context).add(UpdateRequestMenu(item: widget.menu.item, menu: widget.menu.id, amount: value));
                          _updateFieldControllers(widget.menu.id, value, context);
                        });
                      },
                    ),
                  ],
                )
              ),
              ..._buildAdditionalInfo(widget.menu.id, requestMenu?.amount ?? 0)
            ]
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _additionalInfoFilters.forEach((index, controller) => controller.dispose());
    _debounce.cancel();
    super.dispose();
  }

  _buildAdditionalInfo(int id, int amountValue) {
    if (amountValue > 0) {
      return List<Widget>.generate(
        amountValue,
        (i) => TextField(
            controller: _additionalInfoFilters["$id-$i"],
            decoration: new InputDecoration(
              labelText: '${i + 1} additional info',
              contentPadding: const EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: Icon(Icons.announcement),
            ),
          )
      );
    } else {
      return [];
    }
  }

  void _updateFieldControllers(int id, int amount, BuildContext context) {
    for (var i = 0; i <= amount; i += 1) {
      String key = "$id-$i";
      if (_additionalInfoFilters[key] == null) {
        _additionalInfoFilters[key] = TextEditingController();
        _additionalInfoFilters[key].addListener(submitAdditionalInfo(context));
      }
    }
  }

  submitAdditionalInfo(BuildContext context) {
    return () {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
          BlocProvider.of<RequestBloc>(context).add(UpdateAdditionalInfo(
            additionalInfo: _additionalInfoFilters.values.fold('', (prev, element) => '$prev\n${element.text}')
          ));
      });
    };
  }
}