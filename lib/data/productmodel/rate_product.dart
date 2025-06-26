class RateProduct {
  final double rate;
  final int count;

  RateProduct({required this.rate, required this.count});

  factory RateProduct.fromJson(Map<String, dynamic> json) {
    return RateProduct(
      rate: (json["rate"] as num).toDouble(),
      count: json["count"],
    );
  }
}
