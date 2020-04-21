import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class AuthException implements Exception { 
   String errMsg() => 'Username/Password didnt match, please try again'; 
}

class AuthIOException implements Exception { 
   String errMsg() => 'Something went wrong, please try again and communicate our support'; 
}

class AuthService {
  Future<String> authenticate(String username, String password) async {
    final url = 'http://10.0.2.2:8000/api-token-auth/';
    final client = http.Client();
    try {
      final response = await client.post(url, body: {'username': username, 'password': password});
    
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        return body['token'];
      } else {
        throw new AuthException();
      }
    } on http.ClientException {
      throw new AuthIOException();
    } on AuthException {
      throw new AuthException();
    } finally {
      client.close();
    }
  }

  Future<bool> authenticated() async {
    final token = await storage.read(key: 'token');
    return token?.isNotEmpty ?? false;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }

  Future<void> logout() async {
    return await new Future<void>.delayed(
      new Duration(
        seconds: 1
      )
    );
  }
}