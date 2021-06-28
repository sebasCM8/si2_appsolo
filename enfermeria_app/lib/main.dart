import 'package:enfermeria_app/pages/detalle_servicio.dart';
import 'package:enfermeria_app/pages/home_page.dart';
import 'package:enfermeria_app/pages/login_page.dart';
import 'package:enfermeria_app/pages/menu_page.dart';
import 'package:enfermeria_app/pages/registro_exitoso.dart';
import 'package:enfermeria_app/pages/registro_page.dart';
import 'package:enfermeria_app/pages/servicios_page.dart';
import 'package:enfermeria_app/pages/solicitar_atencion_pages/fecha_hora_page.dart';
import 'package:enfermeria_app/pages/solicitar_atencion_pages/final_page.dart';
import 'package:enfermeria_app/pages/solicitar_atencion_pages/servicios_atencion_page.dart';
import 'package:enfermeria_app/pages/solicitar_atencion_pages/solicitud_atencion_exito.dart';
import 'package:enfermeria_app/pages/solicitar_atencion_pages/ubicacion_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'initialPage',
      routes: {
        'initialPage':(context) => HomePage(),
        'loginPage':(context)=>LoginPage(),
        'registerPage':(context)=>RegistrarsePage(),
        'menuPage':(context)=>MenuPage(user:ModalRoute.of(context).settings.arguments),
        'registeredPage':(context)=>RegisteredSuccesfullyPage(user:ModalRoute.of(context).settings.arguments),
        'serviciosPage':(context)=>ServiciosPage(),
        'detalleServicioPage':(context)=>DetalleServicioPage(ser: ModalRoute.of(context).settings.arguments), 
        'solicitarAtencionFechaHora':(context)=>FechaHoraPage(perId: ModalRoute.of(context).settings.arguments,),
        'solicitarAtencionReserva':(context)=>UbicacionPage(res: ModalRoute.of(context).settings.arguments),
        'solicitarAtencionServicios':(context)=>ServiciosAtencionPage(res: ModalRoute.of(context).settings.arguments),
        'solicitarAtencionFinal':(context)=>AtencionFinalPage(resdet: ModalRoute.of(context).settings.arguments,),
        'solicitarAtencionExito':(context)=>SolicitudAtencionExitoPage()
      },
    );
  }
}