import 'package:equatable/equatable.dart';

class Pets extends Equatable {
  final int id;
  final String type;
  final String name;
  final String species;
  final String age;
  final String gender;
  final String size;
  final String description;
  final String photo;

  const Pets({
    required this.id,
    required this.type,
    required this.name,
    required this.species,
    required this.age,
    required this.gender,
    required this.size,
    required this.description,
    required this.photo,
  });

  @override
  List<Object> get props => [
    id,
    type,
    name,
    species,
    age,
    gender,
    size,
    description,
    photo,
  ];
}
