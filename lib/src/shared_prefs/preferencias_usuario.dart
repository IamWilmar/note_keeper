import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  //Ninguna de estas propiedades se usa
  //con patron Singleton

  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();
  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //GET y SET del Color

  get colorTheme {
    return _prefs.getString('color') ?? '0xFFFF7725';
  }

  set colorTheme(String value) {
    _prefs.setString('color', value);
  }

}