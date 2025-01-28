import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibn_sina/core/shared/shared_data.dart';
import '../../config/config.dart';
import '../../data/data_sources/remote/app_remote_data_source.dart';
import '../../data/data_sources/remote/orders_remote_data_source.dart';
import '../../data/data_sources/remote/products_remote_data_source.dart';
import '../../data/data_sources/remote/profile_remote_data_source.dart';
import '../../data/data_sources/remote/quotations_remote_data_source.dart';
import '../../data/repositories/app_repository.dart';
import '../../data/repositories/orders_repository.dart';
import '../../data/repositories/products_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/quotations_repository.dart';
import '../../data/repositories/user_repository.dart';

import '../../data/data_sources/local/user_local_data_source.dart';
import '../../data/data_sources/remote/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../api/api_client.dart';

final locator = GetIt.I;

class ServiceLocator {
  const ServiceLocator._();

  static void init() {
    locator.allowReassignment = true;
    locator.registerLazySingleton(() => GetStorage());
    locator.registerLazySingleton(() => ApiClient());
    locator.registerLazySingleton(() => SharedData());
    locator.registerLazySingleton(() => AppRemoteDataSource(locator()));
    locator.registerLazySingleton(() => UserLocalDataSource(locator()));
    locator.registerLazySingleton(() => AuthRemoteDataSource(locator()));
    locator.registerLazySingleton(() => ProfileRemoteDataSource(locator()));
    locator.registerLazySingleton(() => ProductsRemoteDataSource(locator()));
    locator.registerLazySingleton(() => QuotationsRemoteDataSource(locator()));
    locator.registerLazySingleton(() => OrdersRemoteDataSource(locator()));
    locator.registerLazySingleton(() => AppRepository(locator(), locator()));
    locator.registerLazySingleton(() => AuthRepository(locator(), locator()));
    locator.registerLazySingleton(() => UserRepository(locator()));
    locator.registerLazySingleton(() => OrdersRepository(locator(), locator()));
    locator.registerLazySingleton(
        () => QuotationsRepository(locator(), locator()));
    locator
        .registerLazySingleton(() => ProfileRepository(locator(), locator()));
    locator
        .registerLazySingleton(() => ProductsRepository(locator(), locator()));
  }

  static saveConfig(Config config) {
    locator.registerLazySingleton<Config>(() => config);
  }
}
