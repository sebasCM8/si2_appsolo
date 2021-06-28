import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/generic_actions/validation_methods.dart';
import 'package:enfermeria_app/models/reserva_class.dart';
import 'package:enfermeria_app/models/reserva_detalle_class.dart';
import 'package:enfermeria_app/models/reserva_servicio_class.dart';
import 'package:enfermeria_app/models/servicio_class.dart';
import 'package:flutter/material.dart';

class AtencionFinalPage extends StatefulWidget {
  final ReservaDetalle resdet;
  AtencionFinalPage({this.resdet});
  @override
  _AtencionFinalPageState createState() => _AtencionFinalPageState();
}

class _AtencionFinalPageState extends State<AtencionFinalPage> {
  ReservaDetalle _detalleRes;
  Map<int, TextEditingController> textEditingControllers = {};
  List<Widget> filas = [];
  List _detalle = [];

  @override
  void initState() {
    super.initState();
    _detalleRes = widget.resdet;
    _detalleRes.servicios.forEach((element) {
      var textCtrl = TextEditingController();
      textEditingControllers.putIfAbsent(element.getId(), () => textCtrl);
      Widget fila = Container(
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(10), child: Text(element.getName())),
            Expanded(
                child: TextField(
              controller: textCtrl,
              decoration: InputDecoration(
                  labelText: 'Cantidad..',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder()),
            ))
          ],
        ),
      );
      filas.add(fila);
    });
  }

  void _siguienteBtn() async {
    bool ok = true;
    print("===== Lista =====");
    for (Servicio ser in _detalleRes.servicios) {
      String numberr = textEditingControllers[ser.getId()].text;
      if (isNumeric(numberr)) {
        ReservaXServicio det =
            ReservaXServicio(ser.getId(), int.parse(numberr));
        _detalle.add(det);
        print("${ser.getName()} - $numberr");
      } else {
        ok = false;
        break;
      }
    }
    if (ok) {
      Reserva reservaResponse =
          await Reserva.apiRegisterReserva(_detalleRes.res);
      if (reservaResponse != null) {
        for (ReservaXServicio det in _detalle) {
          det.resId = reservaResponse.getId();
          ReservaXServicio detresponse =
              await ReservaXServicio.apiRegisterResDet(det);
          if (detresponse != null) {
            print("going very well");
          } else {
            ok = false;
          }
        }
        if (ok) {
          Navigator.pushNamed(context, 'solicitarAtencionExito');
        } else {
          wrongDataDialog(context, 'Error al registrar su solicitud', 0);
        }
      }
    } else {
      wrongDataDialog(context, "Debe especificar cada servicio", 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Solicitar atencion"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 8, top: 20, bottom: 10),
              child: littleTitle(
                  'Especifique las cantidades por servicio:', Colors.blue[600]),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
                child: ListView(
              children: filas,
            )),
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
                          "Terminar",
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
