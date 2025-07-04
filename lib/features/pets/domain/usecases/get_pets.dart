import 'package:client/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/pets.dart';
import '../repositories/pets_repository.dart';

class GetPets implements UseCase<List<Pets>, String> {
  final PetsRepository repository;

  GetPets(this.repository);

  @override
  Future<Either<Failure, List<Pets>>> call(String type) async {
    return await repository.getPets(type);
  }
}
