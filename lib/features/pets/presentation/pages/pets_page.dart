import 'package:client/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:client/features/pets/presentation/widgets/animal_type_dropdown.dart';
import 'package:client/features/pets/presentation/widgets/get_pets_button.dart';
import 'package:client/features/pets/presentation/widgets/pets_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  String? _selectedAnimalType;

  final List<String> _animalTypes = ['Dog', 'Cat', 'Rabbit', 'Bird'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AnimalTypeDropdown(
            selectedAnimalType: _selectedAnimalType,
            animalTypes: _animalTypes,
            onChanged: (String? newValue) {
              setState(() {
                _selectedAnimalType = newValue;
              });
            },
          ),
          const SizedBox(height: 20),
          GetPetsButton(
            selectedAnimalType: _selectedAnimalType,
            onPressed: _selectedAnimalType != null
                ? () {
                    BlocProvider.of<PetsBloc>(
                      context,
                    ).add(GetPetsEvent(_selectedAnimalType!));
                  }
                : null,
          ),
          const SizedBox(height: 20),
          Expanded(child: PetsList(selectedAnimalType: _selectedAnimalType)),
        ],
      ),
    );
  }
}
