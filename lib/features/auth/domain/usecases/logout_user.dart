import 'package:client/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUser(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
