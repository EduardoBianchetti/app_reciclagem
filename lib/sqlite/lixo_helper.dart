import 'dart:async';
import 'package:app_reciclagem/model/lixo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String lixoTable = "lixos";
const String idCol = "_id";
const String descricaoCol = "descricao";
const String tipoCol = "tipo";
const String pesoCol = "peso";

class LixoHelper {
  static final LixoHelper _instance = LixoHelper.internal();
  factory LixoHelper() => _instance;
  LixoHelper.internal();
  Database? _db = null;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "baselixos.db");
    return await openDatabase(path, version: 3,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $lixoTable($idCol TEXT PRIMARY KEY, $descricaoCol TEXT, $tipoCol TEXT, $pesoCol TEXT)");
    });
  }

  Future<Lixo> inserir(Lixo lixo) async {
    Database dbLixo = await db;
    int? idNew = Sqflite.firstIntValue(
        await dbLixo.rawQuery("SELECT MAX($idCol) FROM $lixoTable"));
    if (idNew == null) {
      idNew = 1;
    } else {
      idNew = idNew + 1;
    }
    lixo.id = idNew.toString();
    await dbLixo.insert(lixoTable, lixo.toMap());
    return lixo;
  }

  Future<Lixo?> getObjeto(int idFind) async {
    Database dbLixo = await db;
    List<Map<String, dynamic>> maps = await dbLixo.query(lixoTable,
        columns: [idCol, descricaoCol],
        where: "$idCol = ?",
        whereArgs: [idFind]);
    if (maps.isNotEmpty) {
      return Lixo.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> excluir(String idDel) async {
    Database dbLixo = await db;
    return await dbLixo
        .delete(lixoTable, where: "$idCol = ?", whereArgs: [idDel]);
  }

  Future<int> alterar(Lixo lixo) async {
    Database dbLixo = await db;
    return await dbLixo.update(lixoTable, lixo.toMap(),
        where: "$idCol = ?", whereArgs: [lixo.id]);
  }

  Future<List<Lixo>> obterTodos() async {
    Database dbLixo = await initDb();
    List listMap = await dbLixo.rawQuery("SELECT * FROM $lixoTable");
    List<Lixo> listLixo = List.empty(growable: true);
    for (Map<String, dynamic> m in listMap) {
      listLixo.add(Lixo.fromMap(m));
    }
    return listLixo;
  }

  Future<int?> getQuantidade() async {
    Database dbLixo = await db;
    return Sqflite.firstIntValue(
        await dbLixo.rawQuery("SELECT COUNT(*) FROM $lixoTable"));
  }

  Future<int?> getMaiorId() async {
    Database dbLixo = await db;
    return Sqflite.firstIntValue(
        await dbLixo.rawQuery("SELECT MAX(*) FROM $lixoTable"));
  }

  Future close() async {
    Database dbLixo = await db;
    dbLixo.close();
  }
}
