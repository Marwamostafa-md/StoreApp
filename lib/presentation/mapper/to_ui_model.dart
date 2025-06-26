import 'package:storeapp/presentation/uimodel/product.dart';
import '../../domain/entities/product_model.dart';
import '../uimodel/product_rate.dart';

extension toUi on Product {
  ProductUiModel toUiModel() {
    return ProductUiModel(
      id: id,
      title: title,
      price: price,
      description: description,
      image: image,
      productsRating: ProductsRating(
        rate: productRating.rate,
        count: productRating.count,
      ),
    );
  }
}
