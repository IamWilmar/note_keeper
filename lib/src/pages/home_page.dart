import 'dart:math';
import 'package:beautiful_note/src/bloc/note_bloc.dart';
import 'package:beautiful_note/src/pages/note_page.dart';
import 'package:beautiful_note/src/widgets/card_swiper.dart';
import 'package:beautiful_note/src/widgets/list_cards.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle titleStyle = TextStyle(
      fontSize: 40.0, fontWeight: FontWeight.w300, letterSpacing: 2.0);

  final TextStyle subStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w100,
      letterSpacing: 2.0,
      color: Colors.grey[700]);

  final NotesBloc notesBloc = NotesBloc();

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    notesBloc.obtenerNotes();
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: PageView(
          controller: pageController,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _mainPage(_screenSize),
            _noteListPage(),
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  Container _mainPage(Size screenSize) {
    return Container(
      child: Stack(
        children: <Widget>[
          _fondo(),
          _title(),
          CardSwiper(),
          //_vaultsRow(screenSize),
        ],
      ),
    );
  }

  Container _noteListPage() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE8ECEC),
      ),
      child: ListCard(homeScroll: pageController),
    );
  }

  _fondo() {
    final gradiente = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFBFF),
            Color(0xFFE6E2E6),
          ],
        ),
      ),
    );

    final shadow01 = Transform.rotate(
      angle: -pi / 5,
      child: Container(
        height: 500,
        width: 400,
        decoration: BoxDecoration(
          color: Color(0xFFE8ECEC),
        ),
      ),
    );

    final shadow02 = Transform.rotate(
      angle: -pi / 5,
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          color: Color(0xFFD4D8D9),
          //color: Colors.green,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: 490,
          left: -50,
          child: shadow02,
        ),
        Positioned(
          top: 470,
          left: -70,
          child: shadow01,
        ),
      ],
    );
  }

  _title() {
    return SafeArea(
      child: Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Note Keeper", style: titleStyle),
            Text(" All your day here", style: subStyle),
          ],
        ),
      ),
    );
  }

  _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.pushNamed(context, NotePage.routeName);
      },
    );
  }
}
