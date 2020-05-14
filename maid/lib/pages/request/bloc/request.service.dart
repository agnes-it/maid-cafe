import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:maid/auth/auth.service.dart';
import 'package:maid/pages/request/models/request.dart';
import 'package:maid/pages/request/models/request_menu.dart';

final LocalStorage storage = new LocalStorage('requests.json');

class RequestIOException implements Exception { 
   String errMsg() => 'Something went wrong, please try again and communicate our support'; 
}

class RequestService {
  Request request;

  bool hasRequest(int order) {
    return storage.getItem("new_request.$order")?.containsKey('order') ?? false;
  }

  Request getRequest(int order) {
    request = Request.fromJson(storage.getItem("new_request.$order"));
    return request;
  }

  void persistRequest(Request request) {
    storage.setItem("new_request.${request.order}", request.toJson());
  }

  void removeRequest(int order) async {
    await storage.clear();
  }

  Request of(String maid, int order, String table, List<RequestMenu> menus) {
    request = new Request(maid: maid, order: order, table: table, menus: menus);
    return request;
  }

  Request updateAdditionalInfo(String additionalInfo) {
    request.info = additionalInfo;
    return request;
  }

  RequestMenu requestMenu(String item, int menu, int amount) {
    request.menus.removeWhere((requestMenu) => requestMenu.menu == menu);
    if (amount == 0) {
      return new RequestMenu(menu: menu, item: item, amount: 0);
    }
    RequestMenu requestMenu = request.appendMenu(menu, item, amount);
    return requestMenu;
  }

  Future<Request> create(String token, Request request) async {
    final url = 'http://10.0.2.2:8000/api/requests/';
    final client = new AuthenticatedClient(token, http.Client());
    try {
      final response = await client.post(url, body: jsonEncode(request.toJson()));

      if (response.statusCode >= 200 && response.statusCode <= 400) {
        return Request.fromJson(jsonDecode(response.body));
      } else {
        throw new AuthException();
      }
    } on http.ClientException {
      throw new RequestIOException();
    } on AuthException {
      throw new AuthException();
    } finally {
      client.close();
    }
  }
}