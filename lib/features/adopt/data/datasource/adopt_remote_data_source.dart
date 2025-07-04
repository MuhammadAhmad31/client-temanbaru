import 'dart:convert';
import 'package:client/core/errors/failures.dart';
import 'package:client/features/adopt/data/model/adopt_model.dart';
import 'package:client/features/adopt/data/model/adopt_response.dart';
import 'package:http/http.dart' as http;

abstract class AdoptRemoteDataSource {
  Future<List<AdoptModel>> getAdoptRequests(String token);
  Future<void> createAdoptRequest(AdoptModel adoptModel, String token);
}

class AdoptRemoteDataSourceImpl implements AdoptRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AdoptRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<AdoptModel>> getAdoptRequests(String token) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/adoption'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final adoptResponse = AdoptResponse.fromJson(jsonDecode(response.body));
        return adoptResponse.data;
      } else if (response.statusCode == 401) {
        throw ServerException(message: 'Unauthorized');
      } else {
        throw ServerException(message: 'Failed to get adopt requests');
      }
    } catch (e) {
      throw ServerException(message: 'Failed to get adopt requests: $e');
    }
  }

  @override
  Future<void> createAdoptRequest(AdoptModel adoptModel, String token) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/adoption'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(adoptModel.toJson()),
      );

      if (response.statusCode == 201) {
        // Successfully created
      } else if (response.statusCode == 401) {
        throw ServerException(message: 'Unauthorized');
      } else {
        throw ServerException(message: 'Failed to create adopt request');
      }
    } catch (e) {
      throw ServerException(message: 'Failed to create adopt request: $e');
    }
  }
}
