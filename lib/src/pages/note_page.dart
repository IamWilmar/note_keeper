import 'package:beautiful_note/src/bloc/note_bloc.dart';
import 'package:beautiful_note/src/models/note_model.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  static final String routeName = 'note';

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextStyle titleStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w300,
    letterSpacing: 2.0,
    color: Colors.black,
  );

  final TextStyle titleNoteStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w300,
    letterSpacing: 2.0,
    color: Colors.black,
  );

  final TextStyle noteStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w300,
    letterSpacing: 1.0,
    color: Colors.black,
  );

  String _title = " ";
  String _note = " ";
  String _initialTitle = '';
  String _initialNote = '';

  NotesBloc notesBloc = NotesBloc();

  @override
  Widget build(BuildContext context) {
    final NotesModel noteNew = ModalRoute.of(context).settings.arguments;
    if (noteNew != null) {
      _initialTitle = noteNew.title;
      _initialNote = noteNew.note;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title:
              Text('new note', style: titleStyle, textAlign: TextAlign.start),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                if (noteNew == null) {
                  _agregarNota();
                } else {
                  _editarNota(noteNew.id, noteNew);
                }
              },
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titleNote(),
                _contentNote(),
                SizedBox(height: 10),
                // Text(
                //   'Pick a vault',
                //   style: titleNoteStyle,
                // ),
                // SizedBox(height: 10),
                //VaultList(),
                //_vaultSetter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _titleNote() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: _initialTitle,
        style: titleNoteStyle,
        decoration: InputDecoration(
            hintStyle: titleNoteStyle, hintText: 'What is your story...'),
        onChanged: (title) {
          setState(() {
            _title = title;
          });
        },
      ),
    );
  }

  _contentNote() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
      child: Container(
        width: double.infinity,
        height: 200,
        child: TextFormField(
          initialValue: _initialNote,
          style: noteStyle,
          decoration: InputDecoration(hintText: '...'),
          minLines: 5,
          maxLines: null,
          onChanged: (note) {
            setState(() {
              _note = note;
            });
          },
        ),
      ),
    );
  }

  void _agregarNota() {
    NotesModel note = NotesModel(title: _title, note: _note, secret: '');
    notesBloc.agregarNota(note);
    Navigator.pop(context);
  }

  void _editarNota(int id, NotesModel noteNew) {
    if (_title == " ") {
      _title = noteNew.title;
    }
    if (_note == " ") {
      _note = noteNew.note;
    }
    NotesModel note =
        NotesModel(id: id, title: _title, note: _note, secret: '');
    notesBloc.editarNota(note);
    Navigator.pop(context);
  }

}
