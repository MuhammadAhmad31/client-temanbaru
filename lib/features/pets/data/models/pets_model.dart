import '../../domain/entities/pets.dart';
import 'photo_model.dart';
import 'breeds_model.dart';

class PetsModel extends Pets {
  final List<PhotoModel> photos;
  final PhotoModel? primaryPhotoCropped;
  final BreedsModel? breeds;
  final List<String> tags;

  const PetsModel({
    required super.id,
    required super.type,
    required super.name,
    required super.species,
    required super.age,
    required super.gender,
    required super.size,
    required super.description,
    required super.photo,
    required this.photos,
    this.primaryPhotoCropped,
    this.breeds,
    required this.tags,
  });

  factory PetsModel.fromJson(Map<String, dynamic> json) {
    List<PhotoModel> photosList = [];
    if (json['photos'] != null) {
      photosList = (json['photos'] as List)
          .map((photo) => PhotoModel.fromJson(photo))
          .toList();
    }

    PhotoModel? primaryPhoto;
    if (json['primary_photo_cropped'] != null) {
      primaryPhoto = PhotoModel.fromJson(json['primary_photo_cropped']);
    }

    BreedsModel? breedsModel;
    if (json['breeds'] != null) {
      breedsModel = BreedsModel.fromJson(json['breeds']);
    }

    List<String> tagsList = [];
    if (json['tags'] != null) {
      tagsList = (json['tags'] as List).map((tag) => tag.toString()).toList();
    }

    String photoUrl = '';
    if (primaryPhoto != null) {
      photoUrl = primaryPhoto.medium;
    } else if (photosList.isNotEmpty) {
      photoUrl = photosList.first.medium;
    }

    return PetsModel(
      id: json['id'],
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      species: json['species'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      size: json['size'] ?? '',
      description: json['description'] ?? '',
      photo: photoUrl,
      photos: photosList,
      primaryPhotoCropped: primaryPhoto,
      breeds: breedsModel,
      tags: tagsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'species': species,
      'age': age,
      'gender': gender,
      'size': size,
      'description': description,
      'photo': photo,
      'photos': photos
          .map(
            (photo) => {
              'small': photo.small,
              'medium': photo.medium,
              'large': photo.large,
              'full': photo.full,
            },
          )
          .toList(),
      'primary_photo_cropped': primaryPhotoCropped != null
          ? {
              'small': primaryPhotoCropped!.small,
              'medium': primaryPhotoCropped!.medium,
              'large': primaryPhotoCropped!.large,
              'full': primaryPhotoCropped!.full,
            }
          : null,
      'breeds': breeds != null
          ? {
              'primary': breeds!.primary,
              'secondary': breeds!.secondary,
              'mixed': breeds!.mixed,
              'unknown': breeds!.unknown,
            }
          : null,
      'tags': tags,
    };
  }
}
