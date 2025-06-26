import '../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/product_model.dart';
import '../productrepo/product_repo.dart';

class GetAllProductsUseCase {
  final ProductRepo productRepo;

  GetAllProductsUseCase({required this.productRepo});

  Future<Either<Failure, List<Product>>> call() async {
    return productRepo.getAllProducts();
  }
}
