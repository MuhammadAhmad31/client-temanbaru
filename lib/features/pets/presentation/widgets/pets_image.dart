import 'package:client/features/pets/data/models/pets_model.dart';
import 'package:flutter/material.dart';

class PetImage extends StatelessWidget {
  final PetsModel pet;

  const PetImage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: pet.photo.isNotEmpty
            ? Image.network(
                pet.photo,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.pets, size: 40, color: Colors.grey[600]),
                  );
                },
              )
            : Icon(Icons.pets, size: 40, color: Colors.grey[600]),
      ),
    );
  }
}
