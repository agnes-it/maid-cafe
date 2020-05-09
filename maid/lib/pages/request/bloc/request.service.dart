import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maid/pages/request/models/request.dart';
import 'package:maid/pages/request/models/request_menu.dart';

final storage = new FlutterSecureStorage();

class RequestService {
  Request request;

  Future<bool> hasRequest(int order) async {
    final request = await storage.read(key: "new_request.$order");
    return request?.isNotEmpty ?? false;
  }

  Future<Request> getRequest(int order) async {
    return Request.fromJson(jsonDecode(await storage.read(key: "new_request.$order")));
  }

  void persistRequest(Request request) async {
    await storage.write(key: "new_request.${request.order}", value: jsonEncode(request.toJson()));
  }

  Request of(String maid, int order, String table, List<RequestMenu> menus) {
    request = new Request(maid: maid, order: order, table: table, menus: menus);
    return request;
  }

  Request updateAdditionalInfo(String additionalInfo) {
    request.info = additionalInfo;
    return request;
  }

  RequestMenu requestMenu(int menu, int amount) {
    request.menus.removeWhere((requestMenu) => requestMenu.menu == menu);
    if (amount == 0) {
      return new RequestMenu(menu: menu, amount: 0);
    }
    RequestMenu requestMenu = request.appendMenu(menu, amount);
    return requestMenu;
  }
}