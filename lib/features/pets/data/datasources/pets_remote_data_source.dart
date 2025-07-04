import 'dart:convert';
import 'package:client/features/pets/data/models/response_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/failures.dart';
import '../models/pets_model.dart';

abstract class PetsRemoteDataSource {
  Future<List<PetsModel>> getPets(String type);
}

class PetsRemoteDataSourceImpl implements PetsRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  PetsRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<PetsModel>> getPets(String type) async {
    final uri = Uri.parse(
      '$baseUrl/pets',
    ).replace(queryParameters: {'type': type});

    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final petsResponse = PetsResponse.fromJson(json.decode(response.body));
      return petsResponse.data.animals;
    } else {
      throw ServerException();
    }
  }
}
