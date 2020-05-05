import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maid/pages/request/models/menu.dart';
import 'package:maid/auth/auth.service.dart';


class AuthException implements Exception { 
   String errMsg() => 'Error checking your permissions, please try to log in again.'; 
}

class MenuIOException implements Exception { 
   String errMsg() => 'Something went wrong, please try again and communicate our support'; 
}

class MenuService {
  Future<List<Menu>> list(String token) async {
    final url = 'http://10.0.2.2:8000/api/menus/';
    final client = new AuthenticatedClient(token, http.Client());
    try {
      final response = await client.get(url);
    
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        return body.map((rawMenu) {
          return Menu(
            id: rawMenu['id'],
            item: rawMenu['item'],
            description: rawMenu['description'],
            price: rawMenu['price'],
            available: rawMenu['available'],
          );
        }).toList();
      } else {
        throw new AuthException();
      }
    } on http.ClientException {
      throw new MenuIOException();
    } on AuthException {
      throw new AuthException();
    } finally {
      client.close();
    }
  }
}