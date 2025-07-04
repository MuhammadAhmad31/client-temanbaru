import 'package:client/features/adopt/domain/entity/adopt.dart';

class AdoptModel extends Adopt {
  const AdoptModel({
    required super.id,
    required super.name,
    required super.age,
    required super.gender,
    required super.type,
    required super.status,
    required super.animal_id,
    required super.image,
    required super.created_at,
  });

  factory AdoptModel.fromJson(Map<String, dynamic> json) {
    return AdoptModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      type: json['type'],
      status: json['status'],
      animal_id: json['animal_id'],
      image: json['image'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'type': type,
      'status': status,
      'animal_id': animal_id,
      'image': image,
      'created_at': created_at,
    };
  }
}
