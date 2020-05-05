import 'dart:io';
import 'package:beautiful_note/src/models/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Notes ('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'note TEXT,'
          'secret INT'
          ')');
    });
  }

  //nuevoNota
  newNote(NotesModel nuevaNota) async {
    final db = await database;
    final res = await db.insert('Notes', nuevaNota.toJson());
    return res;
  }

  //obtener Nota
  Future<NotesModel> getNoteId(int id) async {
    final db = await database;
    final res = await db.query('Notes', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? NotesModel.fromJson(res.first) : null;
  }

  //Obtener todas las notas
  Future<List<NotesModel>> getAllNotes() async {
    final db = await database;
    final res = await db.query('Notes');
    List<NotesModel> list =
        res.isNotEmpty ? res.map((c) => NotesModel.fromJson(c)).toList() : [];
    return list;
  }

  //Actualizar nota
  Future<int> updateNote(NotesModel newNote) async {
    final db = await database;
    final res = await db.update('Notes', newNote.toJson(),
        where: 'id = ?', whereArgs: [newNote.id]);
    return res;
  }

  //Eliminar nota
  Future<int> deleteNote(int id) async {
    final db = await database;
    final res = await db.delete('Notes', where: 'id = ?', whereArgs: [id] );
    return res;
  }

}
