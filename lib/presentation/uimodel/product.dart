import 'package:equatable/equatable.dart';
import 'package:storeapp/presentation/uimodel/product_rate.dart';

class ProductUiModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final ProductsRating productsRating;

  ProductUiModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.productsRating,
  });

  @override
  List<Object?> get props => [id, title, price, description, image, productsRating,];
}
