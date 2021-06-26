import 'dart:async';

import 'package:enfermeria_app/db_files/db_class.dart';
import 'package:enfermeria_app/models/usuario_class.dart';
import 'package:flutter/material.dart';
import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = DBProvider.instance;
  List usuarios;
  _getUsuarios() async {
    usuarios = await db.getUsuarios();
  }

  void _loadNextPage() {
    Usuario eluser;
    for (Map<String, dynamic> usu in usuarios) {
      Usuario user = Usuario.fromMap(usu);
      if (user.isLogged()) {
        eluser = user;
        break;
      }
    }
    if (eluser != null) {
      Navigator.pushReplacementNamed(context, 'menuPage', arguments: eluser);
    } else {
      Navigator.pushReplacementNamed(context, 'loginPage');
    }
  }

  startTimer() {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, _loadNextPage);
  }

  @override
  void initState() {
    super.initState();
    _getUsuarios();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            bigText("Enfermeria App", Colors.blue),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 40, left: screenwidth * 0.4, right: screenwidth * 0.4),
              child: CircularProgressIndicator(
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
