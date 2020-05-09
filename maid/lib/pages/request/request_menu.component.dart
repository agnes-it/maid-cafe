import 'package:flutter/material.dart';
import 'package:maid/components/flutter_counter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/bloc/menu.service.dart';
import 'package:maid/pages/request/models/menu.dart';
import 'package:maid/pages/request/models/request_menu.dart';
import 'package:maid/pages/request/bloc/request.bloc.dart';

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
  Map<int, TextEditingController> _additionalInfoFilters = {};

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
                          BlocProvider.of<RequestBloc>(context).add(UpdateRequestMenu(menu: widget.menu.id, amount: value));
                          _updateFieldControllers(widget.menu.id, value);
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

  _buildAdditionalInfo(menuName, amountValue) {
    String id = '$menuName';
    if (amountValue > 0) {
      return List<Widget>.generate(
        amountValue,
        (i) => TextField(
            controller: _additionalInfoFilters[id],
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

  void _updateFieldControllers(id, amount) {
    for (var i = 0; i <= amount; i += 1) {
      if (_additionalInfoFilters[id] == null) {
        _additionalInfoFilters[id] = new TextEditingController();
      }
    }
  }
}