import 'package:flutter/material.dart';

class PetsInitialView extends StatelessWidget {
  const PetsInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.pets, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          'Select an animal type and press "Get Pets"',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
