import 'dart:async';

import 'package:beautiful_note/src/models/note_model.dart';
import 'package:beautiful_note/src/provider/db_provider.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  static final NotesBloc _singleton = new NotesBloc._internal();

  factory NotesBloc() {
    return _singleton;
  }

  NotesBloc._internal() {
    obtenerNotes();
  }

  final _notesController = BehaviorSubject<List<NotesModel>>();
  final _pageController  = BehaviorSubject<int>();

  Stream<List<NotesModel>> get notesStream => _notesController.stream;
  Stream<int>             get pageStream  => _pageController.stream; 


  setPage(int val) {
    _pageController.sink.add(val);
  }

  obtenerNotes() async {
    _notesController.sink.add(await DBProvider.db.getAllNotes());
  }

  agregarNota(NotesModel note) async {
    await DBProvider.db.newNote(note);
    obtenerNotes();
  }

  borrarNota(int id) async {
    await DBProvider.db.deleteNote(id);
    obtenerNotes();
  }

  editarNota(NotesModel newNote) async {
    await DBProvider.db.updateNote(newNote);
    obtenerNotes();
  }

  dispose() {
    _notesController?.close();
    _pageController?.close();
  }
}
