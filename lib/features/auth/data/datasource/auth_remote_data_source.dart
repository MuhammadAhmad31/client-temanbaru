import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/errors/failures.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);
  Future<void> logout();
  Future<void> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client httpClient;
  final String baseUrl;

  AuthRemoteDataSourceImpl({required this.httpClient, required this.baseUrl});

  @override
  Future<String> login(String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['success'] == true &&
          responseBody['data']['token'] != null) {
        return responseBody['data']['token'];
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    final response = await httpClient.post(Uri.parse('$baseUrl/auth/logout'));
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['success'] == true || responseBody.containsKey('user')) {
        return;
      } else {
        final errorMessage = responseBody['message'] ?? 'Registration failed';
        throw ServerException(message: errorMessage);
      }
    }
  }
}
