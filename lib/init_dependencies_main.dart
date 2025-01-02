part of 'init_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initProducts();

  // ---------------------------- CORE  ---------------------------

  sl.registerLazySingleton(() => Client());
}

_initProducts() {
  // DATASOURCE
  sl
    ..registerFactory<ProductsRemoteDataSource>(
        () => ProductRemoteDataSrcImpl(client: sl()))

    // REPOSITORY
    ..registerFactory<ProductsRepository>(
        () => ProductRepoImpl(remoteDataSource: sl()))
    // USECASES

    ..registerFactory(() => FetchProducts(repository: sl()))

    // BLOC
    ..registerFactory(() => ProductsBloc(
          sl(),
        ));
}
