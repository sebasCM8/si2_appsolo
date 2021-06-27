import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/models/servicio_class.dart';
import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  List servicios;
  List serviciosItems = [];
  void _getServicios() async {
    servicios = await Servicio.apiGetServicios();
    if (servicios != null) {
      setState(() {
        servicios.forEach((element) {
          Servicio ser = Servicio.fromMapAPI(element);
          serviciosItems.add(ser);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getServicios();
  }

  void _verServicioBtn(Servicio ser) {
    Navigator.pushNamed(context, 'detalleServicioPage', arguments: ser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios"),
      ),
      body: Container(
        child: (serviciosItems == null)
            ? Center(
                child: normalText("No servicios disponibles", Colors.blue),
              )
            : GridView.count(
                padding: EdgeInsets.all(8),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                children: serviciosItems
                    .map((item) => InkWell(
                          onTap: () {
                            _verServicioBtn(item);
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.blue[800]),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              child: littleTitle(item.getName(), Colors.white),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
