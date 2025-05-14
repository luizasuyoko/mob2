import 'package:sqflite/sqflite.dart';
import '../models/nota_model.dart';
import 'package:path/path.dart';

class NotaDbHelper {
  Database? _database; //classe de conexão com o BD

  static const DB_NAME = "notas.db";
  static const TABLE_NAME = "notas";
  static const CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS $TABLE_NAME(id INTERGER PRIMARY KEY AUTOINCREMENT, titulo TEXT NOT NULL, conteudo TEXT NOT NULL)";


  //métodos de conexão

  Future<Database> get database async{
    if(_database != null){
      return _database!; //se já tiver conexão retorna a mesma já estabelecida
    }
    _database = await _initDatabase();
    return _database!;  //caso nao tenha conexão retorna uma nova conexao 
  }

  Future<Database> _initDatabase() async{
    final dbPath = await getDatabasesPath(); //pegar caminho do banco de dados
    final path = join(dbPath, DB_NAME); //o banco de dados e o caminho
  
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(CREATE_TABLE_SQL);
      },
      version: 1,
      //implementaro upgrade version () 
    );
  }

  //crud(nao precisa usar sql)
  //create
  Future<int> insertNota(Nota nota) async{
    final db = await database;
    return db.insert(TABLE_NAME, nota.toMap()); //converte a nota para modelo de db
  }

  //read
  Future<List<Nota>> getNotas() async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(TABLE_NAME);
    return maps.map((e)=> Nota.fromMap(e)).toList();
  }

  //update 
  Future<int> updateNota(Nota nota) async {
    if(nota.id == null){
      throw Exception(); 
    }
    final db = await database;
    return await db.update(
      TABLE_NAME, 
      nota.toMap(), 
      where: "id = ?",
      whereArgs: [nota.id] 
    );
  }

  //delete
  Future<int> deleteNota(int id) async{
    final db = await database;
    return await db.delete(
      TABLE_NAME,
      where:"id=?",
      whereArgs: [id]
    );
  }
}