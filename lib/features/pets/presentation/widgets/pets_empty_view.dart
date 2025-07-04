import 'package:flutter/material.dart';

class PetsEmptyView extends StatelessWidget {
  final String? selectedAnimalType;

  const PetsEmptyView({super.key, required this.selectedAnimalType});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.sentiment_dissatisfied, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          'No $selectedAnimalType pets found',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
