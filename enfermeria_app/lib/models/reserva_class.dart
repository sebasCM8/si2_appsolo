import 'package:http/http.dart' as http;
import 'dart:convert';

class Reserva {
  int _resId;
  String _resFServicio;
  String _resHServicio;
  String _resLat;
  String _resLng;
  int _resEstado;
  int _resPersona;
  void setPerId(int id) => this._resPersona = id;
  void setFecha(String fecha) => this._resFServicio = fecha;
  void setHora(String hora) => this._resHServicio = hora;
  void setLatnLng(String lat, String lng) {
    this._resLat = lat;
    this._resLng = lng;
  }

  int getPerId() => this._resPersona;
  Reserva(this._resFServicio, this._resHServicio, this._resPersona);
  int getId() => this._resId;

  //====================
  //==== API METHODS ===
  //====================
  Reserva.fromAPI(Map<String, dynamic> mapita){
    this._resId = mapita['id'];
    this._resFServicio = mapita['res_fechaServicio'];
    this._resHServicio = mapita['res_horaServicio'];
    this._resLat = mapita['res_lat'].toString();
    this._resLng = mapita['res_lng'].toString();
    this._resEstado = mapita['res_estadoRes'];
    this._resPersona = mapita['res_persona'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = {
      'id': this._resId,
      'res_fechaServicio': this._resFServicio,
      'res_horaServicio': this._resHServicio,
      'res_lat': this._resLat,
      'res_lng': this._resLng,
      'res_estadoRes': this._resEstado,
      'res_persona':this._resPersona
    };
    return mapa;
  }

  static Future<Reserva> apiRegisterReserva(Reserva res) async {
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_insert_reserva/";
    Map<String, dynamic> resmap = res.toMap();
    var response = await http.post(url, body: {
      'res_fechaServicio': resmap['res_fechaServicio'],
      'res_horaServicio': resmap['res_horaServicio'],
      'res_lat': resmap['res_lat'],
      'res_lng': resmap['res_lng'],
      'res_estadoRes':'0',
      'res_estado':'1',
      'res_persona':'${resmap['res_persona']}'
    });
    if (response.statusCode == 201) {
      Map<String, dynamic> reservaobj = json.decode(response.body);
      return Reserva.fromAPI(reservaobj);
    } else {
      return null;
    }
  }
}
