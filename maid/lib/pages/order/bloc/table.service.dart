import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:maid/pages/order/models/table.dart';
import 'package:maid/auth/auth.service.dart';

final storage = new FlutterSecureStorage();

class TableIOException implements Exception { 
   String errMsg() => 'Something went wrong, please try again and communicate our support'; 
}

class TableService {
  Future<List<Table>> list(String token) async {
    final url = 'http://10.0.2.2:8000/api/tables/';
    final client = new AuthenticatedClient(token, http.Client());
    try {
      final response = await client.get(url);
    
      if (response.statusCode >= 200 && response.statusCode <= 400) {
        final body = jsonDecode(response.body) as List;
        return body.map((rawOrder) {
          return Table(
            id: rawOrder['id'],
            number: rawOrder['number'],
            label: rawOrder['label'],
          );
        }).toList();
      } else {
        throw new AuthException();
      }
    } on http.ClientException {
      throw new TableIOException();
    } on AuthException {
      throw new AuthException();
    } finally {
      client.close();
    }
  }
}