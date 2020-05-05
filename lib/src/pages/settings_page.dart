import 'package:beautiful_note/src/bloc/settings_bloc.dart';
import 'package:beautiful_note/src/shared_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextStyle titleStyle = TextStyle(
      fontSize: 30.0, fontWeight: FontWeight.w100, color: Colors.black);
  TextStyle subTitleStyle = TextStyle(
      fontSize: 25.0, fontWeight: FontWeight.w100, color: Colors.black);

  final prefs = PreferenciasUsuario();
  final settingsBloc = SettingsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('Settings', style: titleStyle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title(),
          Divider(color: Theme.of(context).primaryColor, indent: 20.0, endIndent: 20.0,),
          Wrap(
            children: <Widget>[
              _colorButton('0xFFFF7725'),
              _colorButton('0xFF612CAD'),
              _colorButton('0xFFFFC308'),
              _colorButton('0xFF037171'),
              _colorButton('0xFF03312E'),
              _colorButton('0xFF8FB07D'),
              _colorButton('0xFFBE222E'),
              _colorButton('0xFF534D41'),
              _colorButton('0xFF3A606E'),
              _colorButton('0xFF8D6B94'),
              _colorButton('0xFFDAA2A1'),
              _colorButton('0xFF000000'),
            ],
          ),
        ],
      ),
    );
  }

  Container title() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        'Theme',
        style: subTitleStyle,
      ),
    );
  }

  Widget _colorButton(String color) {
    return IconButton(
      icon: Icon(Icons.brightness_1, color: Color(int.parse(color)),),
      onPressed: () {
        settingsBloc.cambiarColor(color);
      },
    );
  }
}
