import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/pets.dart';
import '../../domain/usecases/get_pets.dart';

part 'pets_event.dart';
part 'pets_state.dart';

class PetsBloc extends Bloc<PetsEvent, PetsState> {
  final GetPets getPets;

  PetsBloc({required this.getPets}) : super(PetsInitial()) {
    on<GetPetsEvent>((event, emit) async {
      emit(PetsLoading());
      final failureOrPets = await getPets(event.petsType);
      failureOrPets.fold(
        (failure) => emit(PetsError(_mapFailureToMessage(failure))),
        (pets) => emit(PetsLoaded(pets)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure: Please try again later.';
      case CacheFailure:
        return 'Cache Failure: Data not found in cache.';
      case InvalidInputFailure:
        return 'Invalid Input: Please enter a valid number.';
      default:
        return 'Unexpected error: Please try again.';
    }
  }
}
