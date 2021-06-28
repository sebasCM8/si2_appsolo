import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:flutter/material.dart';

class SolicitudAtencionExitoPage extends StatefulWidget {
  @override
  _SolicitudAtencionExitoPageState createState() =>
      _SolicitudAtencionExitoPageState();
}

class _SolicitudAtencionExitoPageState
    extends State<SolicitudAtencionExitoPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(bottom:20),
              child: littleTitle(
                  'Reserva de atencion registrada con exito, pronto se asignara un enfermero',
                  Colors.blueAccent),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.popUntil(context, ModalRoute.withName('menuPage'));
                    },
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
