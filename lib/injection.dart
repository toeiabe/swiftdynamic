import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:swift/data/repositories/province_repository_impl.dart';
import 'package:swift/domain/usecases/provinces_usecase.dart';
import 'package:swift/presentation/bloc/province_bloc/province_bloc.dart';

import 'data/datasource/remote_datasource.dart';
import 'domain/repositories/province_repository.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => ProvinceBloc());

  // usecase
  locator.registerLazySingleton(() => GetProvince(locator()));

  // repository
  locator.registerLazySingleton<ProvinceRepository>(
    () => ProvinceRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
