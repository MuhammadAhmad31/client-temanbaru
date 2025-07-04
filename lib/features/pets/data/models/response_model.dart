import 'package:client/features/pets/data/models/pets_model.dart';

class PetsResponse {
  final bool success;
  final PetsData data;

  const PetsResponse({required this.success, required this.data});

  factory PetsResponse.fromJson(Map<String, dynamic> json) {
    return PetsResponse(
      success: json['success'] ?? false,
      data: PetsData.fromJson(json['data']),
    );
  }
}

class PetsData {
  final List<PetsModel> animals;

  const PetsData({required this.animals});

  factory PetsData.fromJson(Map<String, dynamic> json) {
    List<PetsModel> animalsList = [];
    if (json['animals'] != null) {
      animalsList = (json['animals'] as List)
          .map((animal) => PetsModel.fromJson(animal))
          .toList();
    }

    return PetsData(animals: animalsList);
  }
}
