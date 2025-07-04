import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure({this.message = 'Server error occurred'});

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {}

class InvalidInputFailure extends Failure {}

class ServerException implements Exception {
  final String message;

  const ServerException({this.message = 'Server error occurred'});
}

class NetworkFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheException implements Exception {}
