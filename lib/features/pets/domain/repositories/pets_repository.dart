import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/pets.dart';

abstract class PetsRepository {
  Future<Either<Failure, List<Pets>>> getPets(String type);
}
