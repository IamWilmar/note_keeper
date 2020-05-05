import 'package:beautiful_note/src/bloc/note_bloc.dart';
import 'package:beautiful_note/src/models/note_model.dart';
import 'package:beautiful_note/src/pages/note_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  final PageController homeScroll;
  ListCard({this.homeScroll});
  @override
  _ListCardState createState() => _ListCardState(homeScroll);
}

class _ListCardState extends State<ListCard> {
  PageController homeScroll;

  _ListCardState(this.homeScroll);

  NotesBloc notesBloc = NotesBloc();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        print("Maximum");
        homeScroll.animateToPage(0,
            duration: Duration(milliseconds: 600), curve: Curves.fastOutSlowIn);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    notesBloc.obtenerNotes();
    return StreamBuilder(
      stream: notesBloc.notesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<NotesModel>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        final notes = snapshot.data;
        if (notes.length == 0) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 230,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: IconButton(
                    icon:
                        Icon(Icons.note_add, size: 80, color: Colors.grey[400]),
                    onPressed: () {
                      Navigator.pushNamed(context, NotePage.routeName);
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    _cardTypeList( context ,notes[index], _screenSize),
                    SizedBox(height: 30.0),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

_cardTypeList(BuildContext context, NotesModel note, Size screenSize) {
  final TextStyle titleStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 35, color: Colors.black);

  final TextStyle noteStyle =
      TextStyle(fontWeight: FontWeight.w200, fontSize: 25, color: Colors.black);

  final card = Container(
    width: screenSize.width * 0.8,
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            note.title,
            style: titleStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            note.note,
            style: noteStyle,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
  );

  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: card,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(2.0, 10.0),
        ),
      ],
    ),
  );
}
