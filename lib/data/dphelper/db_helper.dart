import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'store.db'),
      version: 5,
      onCreate: (db, version)async {
        await db.execute('''
    CREATE TABLE Store(
    id integer primary key ,
    title text not null,
    image text not null,
    price REAL not null,
    description text not null,
    rate REAL not null,
    count REAL not null
   ) ;
    ''');
      },
    );
  }
}
