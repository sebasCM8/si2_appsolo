import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/models/servicio_class.dart';
import 'package:flutter/material.dart';

class DetalleServicioPage extends StatefulWidget {
  final Servicio ser;
  DetalleServicioPage({this.ser});
  @override
  _DetalleServicioPageState createState() => _DetalleServicioPageState();
}

class _DetalleServicioPageState extends State<DetalleServicioPage> {
  Servicio _servicio;
  @override
  void initState() {
    super.initState();
    _servicio = widget.ser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver servicio"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top:15, bottom:20),
              alignment: Alignment.centerLeft,
              child: mediumText(_servicio.getName(), Colors.blueAccent),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.centerLeft,
              child: normalText('Descripcion: ${_servicio.getDesc()}', Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.centerLeft,
              child: normalText('Precio: ${_servicio.getPrecio()}', Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
