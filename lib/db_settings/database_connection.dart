import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_mc_crud_test');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,firstname TEXT,lastname Text,dateOfBirth TEXT,phoneNumber TEXT,email TEXT,bankAccountNumber TEXT);";
    await database.execute(sql);
  }
}
