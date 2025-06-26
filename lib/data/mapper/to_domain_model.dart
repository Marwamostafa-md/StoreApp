import 'package:storeapp/data/productmodel/rate_product.dart';
import 'package:storeapp/domain/entities/product_rating.dart';

import '../../domain/entities/product_model.dart';
import '../productmodel/product_model.dart';

extension toDomain on ProductModel {
  Product toDomainModel() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      image: image,
      productRating: ProductRating(
        rate: rateProduct.rate,
        count: rateProduct.count,
      ),
    );
  }
}
