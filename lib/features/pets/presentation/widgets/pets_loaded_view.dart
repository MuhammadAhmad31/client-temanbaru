import 'package:client/features/pets/presentation/widgets/pet_card.dart';
import 'package:client/features/pets/presentation/widgets/pets_empty_view.dart';
import 'package:flutter/material.dart';

class PetsLoadedView extends StatelessWidget {
  final List<dynamic> pets;
  final String? selectedAnimalType;

  const PetsLoadedView({
    super.key,
    required this.pets,
    required this.selectedAnimalType,
  });

  @override
  Widget build(BuildContext context) {
    if (pets.isEmpty) {
      return PetsEmptyView(selectedAnimalType: selectedAnimalType);
    }

    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        return PetCard(pet: pet);
      },
    );
  }
}
