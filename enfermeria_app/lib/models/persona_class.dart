import 'dart:convert';

import 'package:enfermeria_app/db_files/db_class.dart';
import 'package:http/http.dart' as http;

class Persona {
  int _perId;
  String _perNombre;
  String _perApellidoPaterno;
  String _perApellidoMaterno;
  String _perCelular;
  String _perCI;
  String _perDireccion;
  String _perEmail;
  String _perSexo;

  Persona(
      this._perNombre,
      this._perApellidoPaterno,
      this._perApellidoMaterno,
      this._perCelular,
      this._perCI,
      this._perDireccion,
      this._perEmail,
      this._perSexo);

  Persona.fromMap(Map<String, dynamic> record) {
    this._perId = record[perId];
    this._perNombre = record[perNombre];
    this._perApellidoPaterno = record[perApellidoP];
    this._perApellidoMaterno = record[perApellidoM];
    this._perCelular = record[perCelular];
    this._perCI = record[perCI];
    this._perDireccion = record[perDireccion];
    this._perEmail = record[perEmail];
    this._perSexo = record[perSexo];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> theMap = {
      perId: this._perId,
      perNombre: this._perNombre,
      perApellidoP: this._perApellidoPaterno,
      perApellidoM: this._perApellidoMaterno,
      perCelular: this._perCelular,
      perCI: this._perCI,
      perEmail: this._perEmail,
      perDireccion: this._perDireccion,
      perSexo: this._perSexo
    };
    return theMap;
  }

  void setID(int id) => this._perId = id;
  int getID() => this._perId;
  String getName() => this._perNombre;
  String getCI() => this._perCI;

  // ========================
  // ===== API METHODS ======
  // ========================
  Persona.fromMapAPI(Map<String, dynamic> record) {
    this._perId = record['id'];
    this._perNombre = record[perNombre];
    this._perApellidoPaterno = record[perApellidoP];
    this._perApellidoMaterno = record[perApellidoM];
    this._perCelular = record[perCelular];
    this._perCI = record[perCI];
    this._perDireccion = record[perDireccion];
    this._perEmail = record[perEmail];
    this._perSexo = record[perSexo];
  }

  static Future<Persona> apiGetPersonByID(int id) async {
    Map<String, dynamic> data;
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_persona/$id/";
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      //print(data);
      return Persona.fromMapAPI(data);
    } else {
      return null;
    }
  }

  static Future<Persona> apiGetPersonByCI(String ci) async {
    Map<String, dynamic> data;
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_persona_ci/$ci/";
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      //print(data);
      return Persona.fromMapAPI(data);
    } else {
      return null;
    }
  }

  static Future<Persona> apiRegisterPerson(Persona thePerson) async {
    Map<String, dynamic> personaobj;
    Map<String, dynamic> themap = thePerson.toMap();
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_personas/";
    var response = await http.post(url, body: {
      perNombre: themap[perNombre],
      perApellidoP: themap[perApellidoP],
      perApellidoM: themap[perApellidoM],
      perCelular: themap[perCelular],
      perCI: themap[perCI],
      perDireccion: themap[perDireccion],
      perEmail: themap[perEmail],
      perSexo: themap[perSexo],
      'per_estado': '1'
    });
    if (response.statusCode == 201) {
      personaobj = json.decode(response.body);
      return Persona.fromMapAPI(personaobj);
    } else {
      return null;
    }
  }
}
