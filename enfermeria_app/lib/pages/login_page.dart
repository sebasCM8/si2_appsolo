import 'package:enfermeria_app/db_files/db_class.dart';
import 'package:enfermeria_app/generic_actions/validation_methods.dart';
import 'package:enfermeria_app/models/persona_class.dart';
import 'package:enfermeria_app/models/usuario_class.dart';
import 'package:flutter/material.dart';
import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  int ingresando = 0;
  final db = DBProvider.instance;
  List usuarios;
  Usuario eluser;

  void _getUsuarios() async {
    usuarios = await db.getUsuarios();
  }

  @override
  void initState() {
    super.initState();
    _getUsuarios();
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void buscarLocal() {
    for (Map<String, dynamic> usu in usuarios) {
      Usuario u = Usuario.fromMap(usu);
      if (u.getUsername() == userController.text &&
          u.getPassword() == passwordController.text) {
        eluser = u;
        break;
      }
    }
  }

  Future<void> buscarNube() async{
    Usuario userexiste = await Usuario.apiGetUserUsername(userController.text);
    if(userexiste!=null){
      eluser = userexiste;
      print(eluser.toMap());
      eluser.setLogged();
      Persona personaobj = await Persona.apiGetPersonByID(eluser.getPer());
      if(personaobj!=null){
        print(personaobj.toMap());
        db.insertPersona(personaobj);
        print("persona de la nube registrada en bd local");
        db.insertUsuario(eluser);
        print("usuario de la nube registrado en bd local");
      }
    }
  }

  void _ingresarBtn() async {
    setState(() {
      ingresando = 1;
    });
    if (isNotEmpty(userController.text) &&
        isNotEmpty(passwordController.text)) {

      buscarLocal();
      if(eluser==null){
        await buscarNube();
      }

      if (eluser != null) {
        eluser.setLogged();
        await db.updateUsuario(eluser);
        Navigator.pushReplacementNamed(context, 'menuPage', arguments: eluser);
      } else {
        print("msgerror");
        wrongDataDialog(context, "No se encontro al usuario", 0);
        setState(() {
          ingresando = 0;
        });
      }
    } else {
      wrongDataDialog(context, "Datos erronos", 0);
      setState(() {
        ingresando = 0;
      });
    }
  }

  void _registrarseBtn() {
    print("ir a registrarse...");
    Navigator.pushNamed(context, 'registerPage');
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de sesion"),
      ),
      body: Container(
          child: ListView(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: screenwidth * 0.4,
              height: screenheight * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/loginImage.png',
                    ),
                  ))),
        ]),
        inputForm(userController, Icons.person, "Usuario"),
        inputFormPassword(passwordController, Icons.security, "Contraseña"),
        SizedBox(
          height: 20,
          width: 20,
        ),
        TextButton(
            onPressed: _registrarseBtn,
            child: Text("Aun no te has registrado?..")),
        SizedBox(
          height: 20,
          width: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _ingresarBtn,
                child: Container(
                    alignment: Alignment.center,
                    width: screenwidth * 0.4,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Ingresar",
                      style: TextStyle(fontSize: 22),
                    ))),
          ],
        ),
        (ingresando == 1)
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: 40, left: screenwidth * 0.4, right: screenwidth * 0.4),
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.redAccent[400]),
                ),
              )
            : SizedBox(width: 10, height: 10)
      ])),
    );
  }
}
