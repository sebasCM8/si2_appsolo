import 'package:enfermeria_app/db_files/db_class.dart';
import 'package:enfermeria_app/models/usuario_class.dart';
import 'package:flutter/material.dart';

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
            content: Text(
                "Seguro que desa salir?"),
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

  void _logoutBtn() async{
    user.logout();
    await db.updateUsuario(user);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, 'loginPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu page"),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: _questionDialog,
                    icon: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ))
              ],
            ),
            Center(
              child: Text(
                  "Welcome yo! user ${user.getUsername()} ${user.getPassword()}"),
            ),
          ],
        ),
      ),
    );
  }
}
