import 'dart:convert';

import 'package:enfermeria_app/db_files/db_class.dart';
import 'package:http/http.dart' as http;

class Usuario {
  int _usuId;
  String _usuUsername;
  String _usuPassword;
  int _usuLogged;
  int _usuPer;

  Usuario(this._usuUsername, this._usuPassword, this._usuPer, this._usuLogged);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> theMap = {
      usuId: this._usuId,
      usuUsername: this._usuUsername,
      usuPassword: this._usuPassword,
      usuLogged: this._usuLogged,
      usuPer: this._usuPer
    };
    return theMap;
  }

  Usuario.fromMap(Map<String, dynamic> theMap) {
    this._usuId = theMap[usuId];
    this._usuUsername = theMap[usuUsername];
    this._usuPassword = theMap[usuPassword];
    this._usuLogged = theMap[usuLogged];
    this._usuPer = theMap[usuPer];
  }

  String getUsername() => this._usuUsername;
  String getPassword() => this._usuPassword;
  void setLogged() => this._usuLogged = 1;
  void logout() => this._usuLogged = 0;
  int getID() => this._usuId;
  bool isLogged() => (this._usuLogged == 1);
  int getPer() => this._usuPer;
  int getPerId()=>this._usuPer;

  // ==========================
  // ===== API METHODS ========
  // ==========================
  Usuario.fromMapAPI(Map<String, dynamic> theMap) {
    this._usuId = theMap['id'];
    this._usuUsername = theMap[usuUsername];
    this._usuPassword = theMap[usuPassword];
    this._usuPer = theMap[usuPer];
  }
  static Future<Usuario> apiRegisterUsuario(Usuario user) async {
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_register_usuario/";
    Map<String, dynamic> usermap = user.toMap();
    var response = await http.post(url, body: {
      usuUsername: usermap[usuUsername],
      usuPassword: usermap[usuPassword],
      'usu_estado': '1',
      usuPer: '${usermap[usuPer]}'
    });
    if (response.statusCode == 201) {
      Map<String, dynamic> usuarioobj = json.decode(response.body);
      return Usuario.fromMapAPI(usuarioobj);
    } else {
      return null;
    }
  }

  static Future<Usuario> apiGetUserUsername(String username) async {
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_get_user_username/$username/";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    if(response.statusCode == 200){
      Map<String, dynamic> userobj = json.decode(response.body);
      return Usuario.fromMapAPI(userobj);
    }else{
      return null;
    }
  }
}
