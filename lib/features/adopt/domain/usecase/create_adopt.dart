import 'package:client/core/errors/failures.dart';
import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/adopt/domain/repositories/adopt_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAdoptRequest implements UseCase<void, CreateAdoptRequestParams> {
  final AdoptRepository repository;

  CreateAdoptRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateAdoptRequestParams params) async {
    return await repository.createAdoptRequest(params.idPet);
  }
}

class CreateAdoptRequestParams {
  final int idPet;

  CreateAdoptRequestParams({required this.idPet});
}
