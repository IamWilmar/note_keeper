import 'package:beautiful_note/src/bloc/note_bloc.dart';
import 'package:beautiful_note/src/models/note_model.dart';
import 'package:flutter/material.dart';

class OptionsMenu extends StatelessWidget {
  final NotesModel note;
  OptionsMenu(this.note);
  final TextStyle noteStyle =
      TextStyle(fontWeight: FontWeight.w200, fontSize: 25, color: Colors.black);

  final NotesBloc noteBloc = NotesBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      height: 100,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('What do you want to do?', style: noteStyle),
          SizedBox(height:10.0),
          _deleteButton( context, note.id),
        ],
      ),
    );
  }

  _deleteButton(BuildContext context, int id) {
    return FlatButton.icon(
      onPressed: () {
        noteBloc.borrarNota(id);
        Navigator.pop(context);
      },
      icon: Icon(Icons.delete_outline),
      label: Text('Delete', style: noteStyle ),
    );
  }
}
