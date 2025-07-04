import 'package:flutter/material.dart';

class AnimalTypeDropdown extends StatelessWidget {
  final String? selectedAnimalType;
  final List<String> animalTypes;
  final ValueChanged<String?> onChanged;

  const AnimalTypeDropdown({
    super.key,
    required this.selectedAnimalType,
    required this.animalTypes,
    required this.onChanged,
  });

  IconData _getAnimalIcon(String animalType) {
    switch (animalType.toLowerCase()) {
      case 'dog':
        return Icons.pets;
      case 'cat':
        return Icons.catching_pokemon;
      case 'rabbit':
        return Icons.cruelty_free;
      case 'bird':
        return Icons.flutter_dash;
      default:
        return Icons.pets;
    }
  }

  Color _getAnimalColor(String animalType) {
    switch (animalType.toLowerCase()) {
      case 'dog':
        return const Color(0xFF8B4513);
      case 'cat':
        return const Color(0xFFFF8C00);
      case 'rabbit':
        return const Color(0xFF708090);
      case 'bird':
        return const Color(0xFF4169E1);
      default:
        return const Color(0xFF6B73FF);
    }
  }

  String _getAnimalEmoji(String animalType) {
    switch (animalType.toLowerCase()) {
      case 'dog':
        return '🐕';
      case 'cat':
        return '🐱';
      case 'rabbit':
        return '🐰';
      case 'bird':
        return '🐦';
      default:
        return '🐾';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B73FF).withAlpha((0.1 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedAnimalType,
        decoration: InputDecoration(
          labelText: 'Pilih Jenis Hewan',
          labelStyle: TextStyle(
            color: const Color(0xFF6B73FF).withAlpha((0.7 * 255).round()),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          hintText: 'Pilih jenis hewan kesayangan',
          hintStyle: TextStyle(
            color: Colors.grey.withAlpha((0.6 * 255).round()),
            fontSize: 14,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6B73FF), Color(0xFF9B59B6)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.pets, color: Colors.white, size: 20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFF6B73FF).withAlpha((0.2 * 255).round()),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFF6B73FF).withAlpha((0.2 * 255).round()),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF6B73FF), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE74C3C), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        icon: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF6B73FF).withAlpha((0.1 * 255).round()),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: const Color(0xFF6B73FF).withAlpha((0.7 * 255).round()),
            size: 24,
          ),
        ),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 8,
        menuMaxHeight: 300,
        isDense: false,
        isExpanded: true,
        items: animalTypes.map((String animalType) {
          final isSelected = selectedAnimalType == animalType;

          return DropdownMenuItem<String>(
            value: animalType,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected
                    ? const Color(0xFF6B73FF).withAlpha((0.1 * 255).round())
                    : Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getAnimalColor(
                        animalType,
                      ).withAlpha((0.15 * 255).round()),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _getAnimalColor(
                          animalType,
                        ).withAlpha((0.3 * 255).round()),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      _getAnimalIcon(animalType),
                      color: _getAnimalColor(animalType),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Text(
                    _getAnimalEmoji(animalType),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),

                  Flexible(
                    flex: 1,
                    child: Text(
                      animalType,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF6B73FF)
                            : const Color(0xFF2C3E50),
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B73FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Silakan pilih jenis hewan';
          }
          return null;
        },
      ),
    );
  }
}
