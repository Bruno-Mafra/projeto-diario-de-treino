import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'constants.dart';

class MongoDatabase {
  static var db,
      collecExercicios,
      collecTreinos,
      collecExecucoes,
      collecDispExerc;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    inspect(db);
    await db.open().then((value) {
      print("Mongo Database Connected");
    });
    collecTreinos    = db.collection(C_TREINO);
    collecExercicios = db.collection(C_EXEC);
    collecExecucoes  = db.collection(C_EXEC);
    collecDispExerc  = db.collection(C_DISP_EXE);
  }
}