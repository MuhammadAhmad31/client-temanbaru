import 'package:client/features/adopt/domain/entity/adopt.dart';
import 'package:equatable/equatable.dart';

abstract class AdoptState extends Equatable {
  const AdoptState();

  @override
  List<Object?> get props => [];
}

class AdoptInitial extends AdoptState {}

class AdoptLoading extends AdoptState {}

class AdoptLoaded extends AdoptState {
  final List<Adopt> adoptRequests;

  const AdoptLoaded(this.adoptRequests);

  @override
  List<Object?> get props => [adoptRequests];
}

class AdoptError extends AdoptState {
  final String message;

  const AdoptError(this.message);

  @override
  List<Object?> get props => [message];
}
