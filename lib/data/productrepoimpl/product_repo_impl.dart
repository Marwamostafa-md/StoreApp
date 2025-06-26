import 'package:dartz/dartz.dart';
import 'package:storeapp/core/error/failures.dart';
import 'package:storeapp/data/mapper/to_domain_model.dart';
import 'package:storeapp/domain/productrepo/product_repo.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/network_inf.dart';
import '../../domain/entities/product_model.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

class ProductRepoImpl extends ProductRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts.map((e) => e.toDomainModel()).toList());
      } on ServerException {
        try {
          final localProducts = await localDataSource.getCachedProducts();
          return Right(localProducts.map((e) => e.toDomainModel()).toList());
        } on EmptyCacheException {
          return Left(EmptyCacheFailure());
        }
      }
    } else {
      try {
        print("Network connected: ${networkInfo.isConnected}");
        final localProducts = await localDataSource.getCachedProducts();
        print("Trying to load from local database...");
        //print("Map count from DB: ${map.length}");
        return Right(localProducts.map((e) => e.toDomainModel()).toList());
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
