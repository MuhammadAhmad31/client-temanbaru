import 'package:client/core/errors/failures.dart';
import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/adopt/domain/usecase/get_adopt.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_event.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdoptBloc extends Bloc<AdoptEvent, AdoptState> {
  final GetAdoptRequests getAdoptRequests;

  AdoptBloc({required this.getAdoptRequests}) : super(AdoptInitial()) {
    on<GetAdoptEvent>((event, emit) async {
      emit(AdoptLoading());
      final failureOrAdoptRequests = await getAdoptRequests(NoParams());
      failureOrAdoptRequests.fold(
        (failure) => emit(AdoptError(_mapFailureToMessage(failure))),
        (adoptRequests) => emit(AdoptLoaded(adoptRequests)),
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
