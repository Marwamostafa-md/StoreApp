import 'package:equatable/equatable.dart';
import 'package:storeapp/domain/entities/product_rating.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final ProductRating productRating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.productRating,
  });

  @override
  List<Object?> get props => [id, title, price, description, image, productRating,];
}
