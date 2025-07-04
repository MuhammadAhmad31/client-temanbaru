import 'package:client/features/pets/data/models/pets_model.dart';
import 'package:flutter/material.dart';

class PetDetails extends StatelessWidget {
  final PetsModel pet;

  const PetDetails({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pet.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),

        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).primaryColor.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                pet.type,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            if (pet.species.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(
                '• ${pet.species}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),

        Row(
          children: [
            if (pet.age.isNotEmpty) ...[
              Icon(Icons.cake, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                pet.age,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
            if (pet.age.isNotEmpty && pet.gender.isNotEmpty)
              Text(
                ' • ',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            if (pet.gender.isNotEmpty) ...[
              Icon(
                pet.gender.toLowerCase() == 'male' ? Icons.male : Icons.female,
                size: 14,
                color: pet.gender.toLowerCase() == 'male'
                    ? Colors.blue[600]
                    : Colors.pink[600],
              ),
              const SizedBox(width: 4),
              Text(
                pet.gender,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ],
        ),

        if (pet.size.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.straighten, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                'Size: ${pet.size}',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ],

        const SizedBox(height: 4),

        Text(
          'ID: ${pet.id}',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[500],
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}
