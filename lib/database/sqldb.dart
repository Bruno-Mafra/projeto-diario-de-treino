import 'package:postgres/postgres.dart';
import 'constants.dart';

class SQLDatabase {
  static var db;
  static connect() async {
    db = PostgreSQLConnection(
        SQL_HOST,
        SQL_PORT,
        SQL_DB_NAME,
        username: SQL_USERNAME,
        password: SQL_PASSWORD
    );
    await db.open().then((value) {
      print("PostgreSQL Database Connected");
    });
  }
}