import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservaXServicio{
  int resId;
  int serId;
  int cantidad;

  ReservaXServicio(this.serId, this.cantidad);

  Map<String, dynamic> toMap(){
    Map<String, dynamic> mapa = {
      'res':this.resId,
      'ser':this.serId,
      'cant':this.cantidad
    };
    return mapa;
  }

  //====================
  //=== API METHODS ====
  //====================
  ReservaXServicio.fromAPI(Map<String, dynamic> record){
    this.resId = record['res'];
    this.serId = record['ser'];
    this.cantidad = record['cant'];
  }
  
  static Future<ReservaXServicio> apiRegisterResDet(ReservaXServicio det) async {
    final url =
        "https://sebastiancm.pythonanywhere.com/enfermeria/api_insert_resdet/";
    Map<String, dynamic> resmap = det.toMap();
    var response = await http.post(url, body: {
      'res':'${resmap['res']}',
      'ser':'${resmap['ser']}',
      'cant':'${resmap['cant']}'
    });
    if (response.statusCode == 201) {
      Map<String, dynamic> reservaobj = json.decode(response.body);
      return ReservaXServicio.fromAPI(reservaobj);
    } else {
      return null;
    }
  }
}