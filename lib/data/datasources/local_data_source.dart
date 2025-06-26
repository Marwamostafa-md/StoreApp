import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storeapp/data/productmodel/product_model.dart';
import '../../core/error/exceptions.dart';
import '../dphelper/db_helper.dart';

abstract class LocalDataSource {
  Future<List<ProductModel>> getCachedProducts();

  Future<Unit> cacheProducts(List<ProductModel> postsModel);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DbHelper dbHelper;

  LocalDataSourceImpl({required this.dbHelper});

  @override
  Future<Unit> cacheProducts(List<ProductModel> postsModel) async {
    final db = await dbHelper.getDatabase();
    await db.delete("Store");
    for (final post in postsModel) {
      await db.insert(
        "Store",
        post.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Inserted product id: ${post.id} into local database");
    }
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final db = await dbHelper.getDatabase();
    final List<Map<String, dynamic>> map = await db.query("Store");
    for (var item in map) {
      print('Image URL in DB: ${item['image']}');
    }
    if (map.isNotEmpty) {
      return List.generate(
        map.length,
        (i) => ProductModel.fromJson(map[i]),
      ).toList();
    } else {
      throw EmptyCacheException();
    }
  }
}
