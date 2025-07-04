import 'package:client/core/errors/failures.dart';
import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/adopt/data/model/adopt_model.dart';
import 'package:client/features/adopt/domain/repositories/adopt_repository.dart';
import 'package:dartz/dartz.dart';

class GetAdoptRequests implements UseCase<List<AdoptModel>, NoParams> {
  final AdoptRepository repository;

  GetAdoptRequests(this.repository);

  @override
  Future<Either<Failure, List<AdoptModel>>> call(NoParams params) async {
    return await repository.getAdoptRequests();
  }
}
