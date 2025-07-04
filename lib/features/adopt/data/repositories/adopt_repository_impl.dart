import 'package:client/core/errors/failures.dart';
import 'package:client/features/adopt/data/datasource/adopt_remote_data_source.dart';
import 'package:client/features/adopt/data/model/adopt_model.dart';
import 'package:client/features/adopt/domain/repositories/adopt_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdoptRepositoryImpl implements AdoptRepository {
  final AdoptRemoteDataSource remoteDataSource;

  AdoptRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AdoptModel>>> getAdoptRequests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('CACHED_AUTH_TOKEN');

      if (token == null) {
        return Left(CacheFailure());
      }

      final adoptRequests = await remoteDataSource.getAdoptRequests(token);

      return Right(adoptRequests);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure(message: 'Unknown error: $e'));
    }
  }
}
