import 'package:flutter/material.dart';

class PetsLoadingView extends StatelessWidget {
  final String? selectedAnimalType;

  const PetsLoadingView({super.key, required this.selectedAnimalType});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(
          'Loading $selectedAnimalType pets...',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
