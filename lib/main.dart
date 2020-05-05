import 'package:beautiful_note/src/bloc/settings_bloc.dart';
import 'package:beautiful_note/src/pages/home_page.dart';
import 'package:beautiful_note/src/pages/note_page.dart';
import 'package:beautiful_note/src/pages/settings_page.dart';
import 'package:beautiful_note/src/shared_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = SettingsBloc();
    final prefs = PreferenciasUsuario();
    return StreamBuilder<String>(
      stream: settingsBloc.colorStream,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return mainWidget(prefs.colorTheme);
        }
        return mainWidget(snapshot.data);
      }
    );
  }

  MaterialApp mainWidget(String snapshot) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BeautifulNote',
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          NotePage.routeName: (BuildContext context) => NotePage(),
          SettingsPage.routeName: (BuildContext context) => SettingsPage(),
        },
        theme: ThemeData(
          primaryColor: Color(int.parse(snapshot)),
          secondaryHeaderColor: Color(int.parse(snapshot)),
          appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Color(int.parse(snapshot)))),
        ),
      );
  }
}
