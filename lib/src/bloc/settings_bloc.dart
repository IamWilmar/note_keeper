import 'dart:async';
import 'package:beautiful_note/src/shared_prefs/preferencias_usuario.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  static final SettingsBloc _singleton = new SettingsBloc._internal();

  factory SettingsBloc() {
    return _singleton;
  }

  SettingsBloc._internal();

  final _colorController  = BehaviorSubject<String>();
  Stream<String> get colorStream  => _colorController.stream; 


  cambiarColor(String color) {
    _colorController.sink.add(color);
    PreferenciasUsuario().colorTheme = color;
  }
  dispose() {
    _colorController?.close();
  }
}
