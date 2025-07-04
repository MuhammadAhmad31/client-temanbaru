import 'package:client/features/adopt/presentation/bloc/adopt_bloc.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_state.dart';
import 'package:client/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:client/features/pets/presentation/widgets/pets_error_view.dart';
import 'package:client/features/pets/presentation/widgets/pets_initial_view.dart';
import 'package:client/features/pets/presentation/widgets/pets_loaded_view.dart';
import 'package:client/features/pets/presentation/widgets/pets_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsList extends StatelessWidget {
  final String? selectedAnimalType;

  const PetsList({super.key, required this.selectedAnimalType});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdoptBloc, AdoptState>(
      listener: (context, state) {
        if (state is AdoptCreateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Berhasil mengadopsi hewan! 🐾'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is AdoptCreateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengadopsi: ${state.message}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Center(
        child: BlocBuilder<PetsBloc, PetsState>(
          builder: (context, state) {
            if (state is PetsInitial) {
              return const PetsInitialView();
            } else if (state is PetsLoading) {
              return PetsLoadingView(selectedAnimalType: selectedAnimalType);
            } else if (state is PetsLoaded) {
              return PetsLoadedView(
                pets: state.pets,
                selectedAnimalType: selectedAnimalType,
              );
            } else if (state is PetsError) {
              return PetsErrorView(
                message: state.message,
                selectedAnimalType: selectedAnimalType,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
