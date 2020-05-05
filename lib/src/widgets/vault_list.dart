import 'package:beautiful_note/src/bloc/note_bloc.dart';
import 'package:beautiful_note/src/models/note_model.dart';
import 'package:flutter/material.dart';

class VaultList extends StatelessWidget {
  final NotesBloc notesBloc = NotesBloc();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return StreamBuilder<List<NotesModel>>(
      stream: notesBloc.notesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<NotesModel>> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final List<NotesModel> notes = snapshot.data;
        return Container(
          width: _screenSize.width,
          height: _screenSize.height * 0.07,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  SizedBox(width:20.0),
                  RaisedButton(
                    elevation: 0.0,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      notes[index].id.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width:10.0),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
