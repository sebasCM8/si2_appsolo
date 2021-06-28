import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/models/reserva_class.dart';
import 'package:enfermeria_app/models/reserva_detalle_class.dart';
import 'package:enfermeria_app/models/servicio_class.dart';
import 'package:flutter/material.dart';

class ServiciosAtencionPage extends StatefulWidget {
  final Reserva res;
  ServiciosAtencionPage({this.res});
  @override
  _ServiciosAtencionPageState createState() => _ServiciosAtencionPageState();
}

class _ServiciosAtencionPageState extends State<ServiciosAtencionPage> {
  Reserva _reserva;
  List _servicios;
  List _serviciosItems = [];
  List<Servicio> _serviciosSeleccionados = [];
  void _getServiciosNow() async {
    _servicios = await Servicio.apiGetServicios();
    if (_servicios != null) {
      setState(() {
        _servicios.forEach((element) {
          Servicio ser = Servicio.fromMapAPI(element);
          _serviciosItems.add(ser);
        });
      });
    }
  }

  void initState() {
    super.initState();
    _reserva = widget.res;
    _getServiciosNow();
  }

  void _serviceChecked(Servicio ser) {
    if (_serviciosSeleccionados.contains(ser)) {
      _serviciosSeleccionados.remove(ser);
    } else {
      _serviciosSeleccionados.add(ser);
    }
    /*print("======= Lista ======= ");
    _serviciosSeleccionados.forEach((element) {
      print(element.getName());
    });*/
  }

  void _siguienteBtn(){
    if(_serviciosSeleccionados.length > 0){
      print("going well..");
      ReservaDetalle detalleAtencion = ReservaDetalle(_reserva, _serviciosSeleccionados);
      Navigator.pushNamed(context, 'solicitarAtencionFinal', arguments: detalleAtencion);
    }else{
      wrongDataDialog(context, "Seleccione almenos un servicio para realizar la atencion", 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar servicios"),
      ),
      body: Container(
        child: (_serviciosItems == null)
            ? Center(
                child: Text("No hay servicios disponibles"),
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: _serviciosItems.length,
                          itemBuilder: (BuildContext context, index) {
                            return CheckboxListTile(
                              title: Text(_serviciosItems[index].getName()),
                              secondary: Icon(Icons.local_hospital),
                              value: _serviciosItems[index].added,
                              onChanged: (bool value) {
                                setState(() {
                                  _serviciosItems[index].added = value;
                                  _serviceChecked(_serviciosItems[index]);
                                });
                              },
                              activeColor: Colors.blue,
                              checkColor: Colors.white,
                            );
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: _siguienteBtn,
                          child: Container(
                              alignment: Alignment.center,
                              width: screenwidth * 0.4,
                              height: 50,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "siguiente",
                                style: TextStyle(fontSize: 22),
                              ))),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
