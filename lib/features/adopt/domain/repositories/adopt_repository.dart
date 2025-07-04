import 'package:client/core/errors/failures.dart';
import 'package:client/features/adopt/data/model/adopt_model.dart';
import 'package:dartz/dartz.dart';

abstract class AdoptRepository {
  Future<Either<Failure, List<AdoptModel>>> getAdoptRequests();
  Future<Either<Failure, void>> createAdoptRequest(int idPet);
}
