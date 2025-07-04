part of 'pets_bloc.dart';

abstract class PetsEvent extends Equatable {
  const PetsEvent();

  @override
  List<Object> get props => [];
}

class GetPetsEvent extends PetsEvent {
  final String petsType;

  const GetPetsEvent(this.petsType);

  @override
  List<Object> get props => [petsType];
}
