import 'package:client/features/adopt/data/datasource/adopt_remote_data_source.dart';
import 'package:client/features/adopt/data/repositories/adopt_repository_impl.dart';
import 'package:client/features/adopt/domain/repositories/adopt_repository.dart';
import 'package:client/features/adopt/domain/usecase/create_adopt.dart';
import 'package:client/features/adopt/domain/usecase/get_adopt.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../core/constants/app_constants.dart';

Future<void> init(GetIt sl) async {
  sl.registerFactory(
    () => AdoptBloc(getAdoptRequests: sl(), createAdoptRequest: sl()),
  );

  sl.registerLazySingleton(() => GetAdoptRequests(sl()));
  sl.registerLazySingleton(() => CreateAdoptRequest(sl()));

  sl.registerLazySingleton<AdoptRepository>(
    () => AdoptRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AdoptRemoteDataSource>(
    () =>
        AdoptRemoteDataSourceImpl(client: sl(), baseUrl: AppConstants.BASE_URL),
  );
}
