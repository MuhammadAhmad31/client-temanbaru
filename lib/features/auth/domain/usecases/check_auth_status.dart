import 'package:client/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class CheckAuthStatus implements UseCase<String, NoParams> {
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.checkAuthStatus();
  }
}
