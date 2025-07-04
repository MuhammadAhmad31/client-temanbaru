import 'package:client/features/pets/data/models/pets_model.dart';
import 'package:client/features/pets/presentation/widgets/pet_detail.dart';
import 'package:client/features/pets/presentation/widgets/pets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_bloc.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_event.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_state.dart';

class PetCard extends StatelessWidget {
  final PetsModel pet;
  final VoidCallback? onAdoptTap;

  const PetCard({super.key, required this.pet, this.onAdoptTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FF)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B73FF).withAlpha((0.1 * 255).round()),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: const Color(0xFF6B73FF).withAlpha((0.1 * 255).round()),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: const Color(0xFF6B73FF).withAlpha((0.1 * 255).round()),
          highlightColor: const Color(
            0xFF9B59B6,
          ).withAlpha((0.05 * 255).round()),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.2 * 255).round()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.pets,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Dipilih: ${pet.name} 🐾',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: const Color(0xFF6B73FF),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6B73FF), Color(0xFF9B59B6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF6B73FF,
                        ).withAlpha((0.3 * 255).round()),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: PetImage(pet: pet),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PetDetails(pet: pet),
                      const SizedBox(height: 12),

                      BlocBuilder<AdoptBloc, AdoptState>(
                        builder: (context, adoptState) {
                          bool isAdopting = adoptState is AdoptCreateLoading;

                          return ElevatedButton(
                            onPressed: isAdopting
                                ? null
                                : () {
                                    BlocProvider.of<AdoptBloc>(
                                      context,
                                    ).add(CreateAdoptEvent(idPet: pet.id));
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAdopting
                                  ? Colors.grey
                                  : const Color(0xFF6B73FF),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isAdopting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Adopsi Sekarang',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF6B73FF,
                    ).withAlpha((0.1 * 255).round()),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: const Color(
                      0xFF6B73FF,
                    ).withAlpha((0.7 * 255).round()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
