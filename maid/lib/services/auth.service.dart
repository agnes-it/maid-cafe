import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class AuthService {
  Future<String> login(String username, String password) async {
    final url = 'http://10.0.2.2:8000/api-token-auth/';
    final client = http.Client();
    try {
      final response = await client.post(url, body: {'username': username, 'password': password});
    
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        await storage.write(key: 'token', value: body['token']);
        return body['token'];
      } else {
        return '';
      }
    } finally {
      client.close();
    }
  }

  Future<bool> authenticated() async {
    final token = await storage.read(key: 'token');
    return token?.isNotEmpty ?? false;
  }

  Future<String> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    return await new Future<void>.delayed(
      new Duration(
        seconds: 1
      )
    );
  }
}