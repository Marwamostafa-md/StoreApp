import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:storeapp/data/productrepoimpl/product_repo_impl.dart';
import 'package:storeapp/domain/usecases/get_all_ products.dart'; // تحقق من وجود مسافة هنا!
import 'package:storeapp/presentation/productbloc/product_bloc.dart';
import 'core/network/network_inf.dart';
import 'data/datasources/local_data_source.dart';
import 'data/datasources/remote_data_source.dart';
import 'package:sqflite/sqflite.dart';
import 'data/dphelper/db_helper.dart';
import 'domain/productrepo/product_repo.dart';
import 'data/apiconstant/api_constant.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Bloc
  getIt.registerFactory(() => ProductBloc(getAllProductUseCase: getIt()));

  // Use Cases
  getIt.registerLazySingleton(() => GetAllProductsUseCase(productRepo: getIt()));

  // Repositories
  getIt.registerLazySingleton<ProductRepo>(
        () => ProductRepoImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Data Sources
  getIt.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(dio: getIt()),
  );

  getIt.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(dbHelper: getIt()),
  );

  // Network Info
  getIt.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(internetConnectionChecker: getIt()),
  );

  // Dio with BaseOptions
  getIt.registerLazySingleton<Dio>(() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstant.productsBaseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
      ),
    );
  });


  getIt.registerLazySingleton<DbHelper>(() => DbHelper());

  getIt.registerLazySingletonAsync<Database>(() async {
    final dbHelper = getIt<DbHelper>();
    return await dbHelper.getDatabase();
  });

  // Internet Checker
  getIt.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
