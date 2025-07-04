import 'package:client/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:client/features/auth/data/datasource/local/auth_local_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final token = await remoteDataSource.login(email, password);
      await localDataSource.cacheAuthToken(token);
      return Right(token);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearAuthToken();
      return Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      await remoteDataSource.register(name, email, password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> checkAuthStatus() async {
    try {
      final token = await localDataSource.getAuthToken();
      return Right(token);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
