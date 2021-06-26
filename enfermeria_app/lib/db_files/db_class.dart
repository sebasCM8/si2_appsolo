import 'dart:io';
import 'package:enfermeria_app/models/persona_class.dart';
import 'package:enfermeria_app/models/usuario_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String tablePersona = "Persona";
final String perId = "per_id"; // PK
final String perNombre = "per_nombre";
final String perApellidoP = "per_apellidoP";
final String perApellidoM = "per_apellidoM";
final String perCelular = "per_celular";
final String perCI = "per_ci";
final String perDireccion = "per_direccion";
final String perEmail = "per_email";
final String perSexo = "per_sexo"; 

final String databaseName = "Enfermeria_local_db";

final String tableUsuario = "Usuario";
final String usuId = "usu_id"; //PK
final String usuUsername = "usu_username";
final String usuPassword = "usu_password";
final String usuLogged = "usu_logged";
final String usuPer = "usu_per"; // FK persona

class DBProvider {
  Database _database;

  DBProvider._privateContructor();
  static final DBProvider instance = DBProvider._privateContructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await open(path);
  }

  Future _onCreate(Database db, int version) async {
    String tablapersona = """
      create table $tablePersona(
        $perId integer primary key,
        $perNombre text not null,
        $perApellidoP text,
        $perApellidoM text,
        $perCelular text not null,
        $perCI text not null,
        $perDireccion text,
        $perEmail text,
        $perSexo text not null
      );
    """;

    String tablaUsuario = """
      create table $tableUsuario(
        $usuId integer primary key,
        $usuUsername text,
        $usuPassword text,
        $usuLogged integer not null,
        $usuPer integer not null,

        FOREIGN KEY ($usuPer) REFERENCES $tablePersona($perId)
      );
    """;

    await db.execute(tablapersona);
    await db.execute(tablaUsuario);
  }

  Future open(String path) async {
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future close() async => _database.close();

  /* ==============================
  ======== PERSONAS METODOS =======
  ============================== */
  Future<void> insertPersona(Persona personita) async {
    Database db = await instance.database;
    await db.insert(tablePersona, personita.toMap());
  }
  Future<Persona> getPersona(int personaID) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(tablePersona,
        columns: [
          perId,
          perNombre,
          perApellidoP,
          perApellidoM,
          perCelular,
          perCI,
          perDireccion,
          perEmail,
          perSexo
        ],
        where: '$perId = ?',
        whereArgs: [personaID]);
    if (maps.length > 0) {
      return Persona.fromMap(maps.first);
    } else {
      return null;
    }
  }
  /* ==============================
  ======== USUARIO METODOS =======
  ============================== */
  Future<void> insertUsuario(Usuario user) async {
    Database db = await instance.database;
    await db.insert(tableUsuario, user.toMap());
  }
  Future<Usuario> getUsuario(int userID) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(tableUsuario,
        columns: [
          usuId,
          usuUsername,
          usuPassword,
          usuLogged,
          usuPer
        ],
        where: '$usuId = ?',
        whereArgs: [userID]);
    if (maps.length > 0) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }
  Future<List<Map<String, dynamic>>> getUsuarios() async {
    Database db = await instance.database;
    return db.query(tableUsuario);
  }
  Future<void> updateUsuario(Usuario user) async {
    Database db = await instance.database;
    await db.update(tableUsuario, user.toMap(),
        where: '$usuId = ?', whereArgs: [user.getID()]);
  }
}
