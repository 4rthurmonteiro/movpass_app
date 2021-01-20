import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movpass_app/core/database/database_helper.dart';
import 'package:movpass_app/core/network/network_info.dart';
import 'package:movpass_app/core/utils/input_converter.dart';
import 'package:movpass_app/features/modality/data/datasources/modality_remote_data_source.dart';
import 'package:movpass_app/features/modality/data/repositories/modality_repository_impl.dart';
import 'package:movpass_app/features/modality/domain/repositories/modality_repository.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_all_modalities.dart';
import 'package:movpass_app/features/modality/domain/usecases/get_modality_by_id.dart';
import 'package:movpass_app/features/modality/presentation/bloc/bloc.dart';

import 'features/modality/data/datasources/modality_local_data_source.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Modality
  // ** Bloc **
  sl.registerFactory(
    () => ModalityBloc(
      modalities: sl(),
      modality: sl(),
      inputConverter: sl(),
    ),
  );

  // ** Use cases **
  sl.registerLazySingleton(() => GetModalityById(sl()));
  sl.registerLazySingleton(() => GetAllModalities(sl()));

  // Repository
  sl.registerLazySingleton<ModalityRepository>(
    () => ModalityRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ModalityRemoteDataSource>(
    () => ModalityRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<ModalityLocalDataSource>(
    () => ModalityLocalDataSourceImpl(
      databaseHelper: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  // External
  final databaseHelper = await DatabaseHelper.getInstance().db;

  sl.registerLazySingleton(() => databaseHelper);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());


}
