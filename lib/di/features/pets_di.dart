import 'package:get_it/get_it.dart';
import '../../features/pets/data/datasources/pets_remote_data_source.dart';
import '../../features/pets/data/repositories/pets_repository_impl.dart';
import '../../features/pets/domain/repositories/pets_repository.dart';
import '../../features/pets/domain/usecases/get_pets.dart';
import '../../features/pets/presentation/bloc/pets_bloc.dart';
import '../../core/constants/app_constants.dart';

Future<void> init(GetIt sl) async {
  sl.registerFactory(() => PetsBloc(getPets: sl()));

  sl.registerLazySingleton(() => GetPets(sl()));

  sl.registerLazySingleton<PetsRepository>(
    () => PetsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<PetsRemoteDataSource>(
    () =>
        PetsRemoteDataSourceImpl(client: sl(), baseUrl: AppConstants.BASE_URL),
  );
}
