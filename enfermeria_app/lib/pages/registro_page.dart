import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/db_files/db_class.dart';
import 'package:enfermeria_app/generic_actions/validation_methods.dart';
import 'package:enfermeria_app/models/persona_class.dart';
import 'package:enfermeria_app/models/usuario_class.dart';
import 'package:flutter/material.dart';

class RegistrarsePage extends StatefulWidget {
  @override
  _RegistrarsePageState createState() => _RegistrarsePageState();
}

enum sexo { hombre, mujer }

class _RegistrarsePageState extends State<RegistrarsePage> {
  final _nameCtrl = TextEditingController();
  final _apaternoCtrl = TextEditingController();
  final _amaternoCtrl = TextEditingController();
  final _celularCtrl = TextEditingController();
  final _ciCtrl = TextEditingController();

  sexo _personaEs = sexo.mujer;

  final db = DBProvider.instance;

  @override 
  void dispose(){
    _nameCtrl.dispose();
    _apaternoCtrl.dispose();
    _amaternoCtrl.dispose();
    _celularCtrl.dispose();
    _ciCtrl.dispose();
    super.dispose();
  }

  void _registrarmeBtn() async {
    if (isNotEmpty(_nameCtrl.text) &&
        isNotEmpty(_apaternoCtrl.text) &&
        isNotEmpty(_amaternoCtrl.text) &&
        isNumeric(_celularCtrl.text) &&
        isNumeric(_ciCtrl.text)) {
      Persona existe = await Persona.apiGetPersonByCI(_ciCtrl.text);
      if (existe != null) {
        wrongDataDialog(context, "the ci number already is registered", 0);
      } else {
        String genero;
        if (_personaEs == sexo.hombre)
          genero = 'm';
        else
          genero = 'f';
        Persona laPersona = Persona(
            _nameCtrl.text,
            _apaternoCtrl.text,
            _amaternoCtrl.text,
            _celularCtrl.text,
            _ciCtrl.text,
            '',
            '',
            genero);
        Persona registroResponse = await Persona.apiRegisterPerson(laPersona);
        if (registroResponse != null) {
          laPersona.setID(registroResponse.getID());
          db.insertPersona(laPersona);

          String name1 = laPersona.getName().replaceAll(' ', '');
          String username = name1.substring(0, 1) + laPersona.getCI();

          Usuario user =
              Usuario(username, laPersona.getCI(), laPersona.getID(), 0);
          Usuario registerUserResponse = await Usuario.apiRegisterUsuario(user);
          if (registerUserResponse != null) {
            db.insertUsuario(user);
            Navigator.pushReplacementNamed(context, 'registeredPage', arguments: user);
          } else {
            wrongDataDialog(context, "No se pudo registrar usuario", 0);
          }
        } else {
          wrongDataDialog(context, "No se pudo registrar persona", 0);
        }
      }
    } else {
      wrongDataDialog(context, "Datos erronos", 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    //double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Registro de persona")),
      body: Container(
        child: ListView(
          children: [
            Container(
              child: mediumText('Datos personales:', Colors.black87),
              margin: EdgeInsets.only(left: 20, top: 25, bottom: 10),
              alignment: Alignment.centerLeft,
            ),
            inputForm(_nameCtrl, Icons.create_rounded, "Nombre"),
            inputForm(_apaternoCtrl, Icons.create_rounded, "Apellido paterno"),
            inputForm(_amaternoCtrl, Icons.create_rounded, "Apellido materno"),
            inputFormNumbers(_celularCtrl, Icons.phone, "Numero de celular"),
            inputFormNumbers(
                _ciCtrl, Icons.person_outline, "Numero de carnet de identidad"),
            Container(
              child: mediumText('Sexo:', Colors.black),
              margin: EdgeInsets.only(left: 20, top: 25, bottom: 10),
              alignment: Alignment.centerLeft,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Mujer",
                      style: TextStyle(fontSize: 20),
                    ),
                    leading: Radio(
                      value: sexo.mujer,
                      groupValue: _personaEs,
                      onChanged: (sexo value) {
                        setState(() {
                          _personaEs = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Hombre",
                      style: TextStyle(fontSize: 20),
                    ),
                    leading: Radio(
                      value: sexo.hombre,
                      groupValue: _personaEs,
                      onChanged: (sexo value) {
                        setState(() {
                          _personaEs = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _registrarmeBtn,
                    child: Container(
                        alignment: Alignment.center,
                        width: screenwidth * 0.4,
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Registrarme",
                          style: TextStyle(fontSize: 22),
                        ))),
              ],
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
