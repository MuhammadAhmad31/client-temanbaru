import 'package:client/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsErrorView extends StatelessWidget {
  final String message;
  final String? selectedAnimalType;

  const PetsErrorView({
    super.key,
    required this.message,
    required this.selectedAnimalType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
        const SizedBox(height: 16),
        Text(
          'Error: $message',
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: selectedAnimalType != null
              ? () {
                  BlocProvider.of<PetsBloc>(
                    context,
                  ).add(GetPetsEvent(selectedAnimalType!));
                }
              : null,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}
