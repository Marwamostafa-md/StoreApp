import 'package:dio/dio.dart';
import 'package:storeapp/data/productmodel/product_model.dart';
import '../../core/error/exceptions.dart';
import '../apiconstant/api_constant.dart';

abstract class RemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await dio.get('${ApiConstant.productsEndpoint}');

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
