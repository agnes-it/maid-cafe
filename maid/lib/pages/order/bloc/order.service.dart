import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:maid/pages/order/models/order.dart';
import 'package:maid/auth/auth.service.dart';

final storage = new FlutterSecureStorage();

class OrderIOException implements Exception { 
   String errMsg() => 'Something went wrong, please try again and communicate our support'; 
}

class OrderService {
  Future<List<Order>> list(String token) async {
    final url = 'http://10.0.2.2:8000/api/orders/';
    final client = new AuthenticatedClient(token, http.Client());
    try {
      final response = await client.get(url);
    
      if (response.statusCode >= 200 && response.statusCode <= 400) {
        final body = jsonDecode(response.body) as List;
        return body.map((rawOrder) {
          return Order(
            id: rawOrder['id'],
            client: rawOrder['client'],
            table: rawOrder['table'],
          );
        }).toList();
      } else {
        throw new AuthException();
      }
    } on http.ClientException {
      throw new OrderIOException();
    } on AuthException {
      throw new AuthException();
    } finally {
      client.close();
    }
  }

  Future<Order> create(String token, Order order) async {
    final url = 'http://10.0.2.2:8000/api/orders/';
    final client = new AuthenticatedClient(token, http.Client());
    try {
      final response = await client.post(url, body: jsonEncode({'client': order.client, 'table': order.table}));

      if (response.statusCode >= 200 && response.statusCode <= 400) {
        return Order.fromJson(jsonDecode(response.body));
      } else {
        throw new AuthException();
      }
    } on http.ClientException {
      throw new OrderIOException();
    } on AuthException {
      throw new AuthException();
    } finally {
      client.close();
    }
  }
}