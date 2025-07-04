import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/pets.dart';
import '../../domain/repositories/pets_repository.dart';
import '../datasources/pets_remote_data_source.dart';

class PetsRepositoryImpl implements PetsRepository {
  final PetsRemoteDataSource remoteDataSource;

  PetsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Pets>>> getPets(String type) async {
    try {
      final petsModels = await remoteDataSource.getPets(type);
      return Right(petsModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
