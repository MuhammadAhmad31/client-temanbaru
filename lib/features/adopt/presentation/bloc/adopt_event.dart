import 'package:equatable/equatable.dart';

abstract class AdoptEvent extends Equatable {
  const AdoptEvent();

  @override
  List<Object?> get props => [];
}

class GetAdoptEvent extends AdoptEvent {
  const GetAdoptEvent();

  @override
  List<Object?> get props => [];
}
