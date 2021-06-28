import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/db_files/db_class.dart';
import 'package:enfermeria_app/models/usuario_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MenuPage extends StatefulWidget {
  final Usuario user;
  MenuPage({this.user});
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Usuario user;
  final db = DBProvider.instance;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  Future<void> _questionDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("AVISO", style: TextStyle(color: Colors.yellow[800])),
            content: Text("Seguro que desa salir?"),
            actions: [
              TextButton(
                  onPressed: _logoutBtn,
                  child: Text("SI",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("NO",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)))
            ],
          );
        });
  }

  void _logoutBtn() async {
    user.logout();
    await db.updateUsuario(user);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, 'loginPage');
  }

  void _verServicioBtn(){
    Navigator.pushNamed(context, 'serviciosPage');
  }

  @override
  Widget build(BuildContext context) {
    //double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: mediumText("Bienvenido usuario", Colors.lightBlue),
            ),
            Container(
              margin: EdgeInsets.zero,
              child: Image(
                image: AssetImage('assets/images/menuImage3.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(14),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Saludos querido usuario, nuestra aplicacion ofrece los servicios de enfermeria",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                          "a domicilio a travez de atenciones que puedes realizar en el menu de opciones, tambien",
                          style: TextStyle(fontSize: 18)),
                      Text(
                          "puedes ver los servicios que la enfermeria brinda, no dudes en llamarnos si requieres una atencion.",
                          style: TextStyle(fontSize: 18))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24,),
                )),
            ListTile(
              leading: Icon(Icons.explore, color: Colors.blue,),
              title: Text("Servicios"),
              onTap: _verServicioBtn,
            ),
            ListTile(
              leading: Icon(Icons.phone_callback, color: Colors.green,),
              title: Text("Solicitar Atencion"),
              onTap: (){
                Navigator.pushNamed(context, 'solicitarAtencionFechaHora', arguments: user.getPerId());
              },
            ),
            ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Salir"),
                onTap: _questionDialog)
          ],
        ),
      ),
    );
  }
}
