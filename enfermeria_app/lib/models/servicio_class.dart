import 'package:http/http.dart' as http;
import 'dart:convert';

class Servicio {
  int _serId;
  String _serNombre;
  String _serDesc;
  double _serPrecio;
  Servicio(this._serId, this._serNombre, this._serDesc, this._serPrecio);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> unmap = {
      'id': this._serId,
      'ser_nombre': this._serNombre,
      'ser_desc': this._serDesc,
      'ser_precio': this._serPrecio
    };
    return unmap;
  }

  String getName() => this._serNombre;
  String getDesc() => this._serDesc;
  double getPrecio() => this._serPrecio;
  // ==========================
  // ========= API METHODS ====
  // ==========================
  Servicio.fromMapAPI(Map<String, dynamic> record) {
    this._serId = record['id'];
    this._serNombre = record['ser_nombre'];
    this._serDesc = record['ser_desc'];
    this._serPrecio = double.parse(record['ser_precio']);
  }

  static Future<List> apiGetServicios() async {
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_get_servicios/";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      List servicios = json.decode(response.body);
      return servicios;
    } else {
      return null;
    }
  }
}
