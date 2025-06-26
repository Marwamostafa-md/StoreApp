import 'package:storeapp/data/productmodel/rate_product.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final RateProduct rateProduct;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rateProduct,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "image": image,
      "rate": rateProduct.rate,
      "count": rateProduct.count,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      image: json["image"],
      rateProduct: json["rating"] != null
          ? RateProduct.fromJson(json["rating"])
          : RateProduct(
        rate: (json["rate"] as num).toDouble(),
        count: (json["count"] as num).toInt(),
      ),
    );
  }

}
