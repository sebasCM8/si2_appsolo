import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/models/usuario_class.dart';
import 'package:flutter/material.dart';

class RegisteredSuccesfullyPage extends StatefulWidget {
  final Usuario user;
  RegisteredSuccesfullyPage({this.user});
  @override
  _RegisteredSuccesfullyPageState createState() =>
      _RegisteredSuccesfullyPageState();
}

class _RegisteredSuccesfullyPageState extends State<RegisteredSuccesfullyPage> {
  Usuario user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  void _okBtn(){
    Navigator.popUntil(context, ModalRoute.withName('loginPage'));
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top:30, bottom:15),
              alignment: Alignment.center,
              child: mediumText('Registrado exitosamente', Colors.blue),
            ),
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: normalText('Usuario: ${user.getUsername()}', Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(top:10, bottom:30),
              alignment: Alignment.center,
              child:
                  normalText('Contraseña: ${user.getPassword()}', Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _okBtn,
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
            ),
          ],
        ),
      ),
    );
  }
}
