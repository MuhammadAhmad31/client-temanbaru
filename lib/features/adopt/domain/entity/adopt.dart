import 'package:equatable/equatable.dart';

class Adopt extends Equatable {
  final int id;
  final String name;
  final String age;
  final String gender;
  final String type;
  final String status;
  final int animal_id;
  final String image;
  final String created_at;

  const Adopt({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.type,
    required this.status,
    required this.animal_id,
    required this.image,
    required this.created_at,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    age,
    gender,
    type,
    status,
    animal_id,
    image,
    created_at,
  ];
}
