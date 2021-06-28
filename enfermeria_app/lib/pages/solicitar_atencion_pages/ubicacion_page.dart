import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/models/reserva_class.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

class UbicacionPage extends StatefulWidget {
  final Reserva res;
  UbicacionPage({this.res});
  @override
  _UbicacionPageState createState() => _UbicacionPageState();
}

class _UbicacionPageState extends State<UbicacionPage> {
  Reserva _reserva;

  GoogleMapsController gmapController;
  LatLng _target = LatLng(-17.784052, -63.181017);
  String _lat;
  String _lng;

  @override
  void initState() {
    super.initState();
    _reserva = widget.res;
    gmapController = GoogleMapsController(
      initialCameraPosition: CameraPosition(target: _target, zoom: 10.0),
      onTap: (latlng) {
        if (gmapController.markers.length > 0) {
          var marcador = gmapController.markers.last;
          gmapController.markers.remove(marcador);
        }
        String marcadorId =
            latlng.latitude.toString() + latlng.longitude.toString();

        setState(() {
          _lat = latlng.latitude.toString();
          _lng = latlng.longitude.toString();
        });

        Marker nuevoMarcador = Marker(
            markerId: MarkerId(marcadorId),
            position: latlng,
            icon: BitmapDescriptor.defaultMarker);
        gmapController.addMarker(nuevoMarcador);
      },
    );
  }

  void _siguiente(){
    print("going well");
    if(_lat != null && _lng != null){
      _reserva.setLatnLng(_lat, _lng);
      Navigator.pushNamed(context, 'solicitarAtencionServicios', arguments: _reserva);
    }else{
      wrongDataDialog(context, "Debe seleccionar su ubicacion", 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccione la ubicacion"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: GoogleMaps(controller: gmapController)),
            SafeArea(
                child: Row(
              children: [
                Expanded(
                  child: ListTile(
                      subtitle: Text("Latitud"),
                      title: Text(_lat == null ? "" : _lat)),
                ),
                Expanded(
                  child: ListTile(
                      subtitle: Text("Longitud"),
                      title: Text(_lng == null ? "" : _lng)),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue)),
                      onPressed: _siguiente,
                      child: Text(
                        "siguiente",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
