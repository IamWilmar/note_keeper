import 'package:beautiful_note/src/bloc/note_bloc.dart';
import 'package:beautiful_note/src/models/note_model.dart';
import 'package:beautiful_note/src/pages/note_page.dart';
import 'package:beautiful_note/src/pages/settings_page.dart';
import 'package:beautiful_note/src/shared/options_modal.dart';
import 'package:beautiful_note/src/shared_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final notesBloc = NotesBloc();
  final TextStyle titleStyle = TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 2.0,
      color: Colors.white);
  final TextStyle noteStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 2.0,
      color: Colors.white);

  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
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
                _settingsButton(context),
                SizedBox(
                  height: _screenSize.height * 0.15,
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

        return Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: _settingsButton(context),
            ),
            SizedBox(height: 100.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Swiper(
                  // pagination: new SwiperPagination(                    
                  //   margin: new EdgeInsets.fromLTRB(0.0, 270.0, 0.0, 30.0),
                  //   builder: new DotSwiperPaginationBuilder(
                  //     color: Colors.black38,
                  //     activeColor: Theme.of(context).primaryColor,
                  //     activeSize: 20.0,                      
                  //   ),
                  // ),
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 2.0,
                  loop: true,
                  layout: SwiperLayout.STACK,
                  itemCount: notes.length,
                  itemWidth: _screenSize.width * 0.6,
                  itemHeight: _screenSize.height * 0.4,
                  itemBuilder: (BuildContext context, int index) {
                    return _cardContent(context, notes[index], _screenSize);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Row _settingsButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 42.0),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
          ),
        ),
      ],
    );
  }

  Widget _cardContent(BuildContext context, NotesModel note, Size screenSize) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NotePage.routeName, arguments: note);
        },
        onLongPress: () {
          _deleteEdit(context, note);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(int.parse(prefs.colorTheme)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10.0,
              runAlignment: WrapAlignment.start,
              runSpacing: 10.0,
              direction: Axis.vertical,
              children: <Widget>[
                Container(
                  width: screenSize.width * 0.55,
                  child: Text(
                    note.title,
                    style: titleStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 5,
                  height: 5,
                  color: Colors.white,
                ),
                Container(
                  width: screenSize.width * 0.5,
                  child: Text(
                    note.note,
                    style: noteStyle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center, 
                    maxLines: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteEdit(BuildContext context, NotesModel note) {
    showModalBottomSheet(
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(),
        ),
        builder: (context) {
          return OptionsMenu(note);
        });
  }
}
