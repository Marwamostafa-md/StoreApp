import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> getAllProducts();
}
