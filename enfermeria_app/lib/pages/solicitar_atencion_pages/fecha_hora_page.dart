import 'package:enfermeria_app/costum_widgets/generic_widgets.dart';
import 'package:enfermeria_app/models/reserva_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FechaHoraPage extends StatefulWidget {
  final int perId;
  FechaHoraPage({this.perId});
  @override
  _FechaHoraPageState createState() => _FechaHoraPageState();
}

class _FechaHoraPageState extends State<FechaHoraPage> {
  DateTime _dateTime;
  String formatedDate;
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  TimeOfDay time;
  TimeOfDay picked;

  int perID;
  @override
  void initState() {
    super.initState();
    perID = widget.perId;
    time = TimeOfDay.now();
  }

  Future<void> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);
    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

  void _siguienteBtn() {
    print("checking....");
    if (_dateTime != null) {
      bool ok = true;
      int todayDay = DateTime.now().day;
      int selectedDay = _dateTime.day;

      int todayMonth = DateTime.now().month;
      int selectedMonth = _dateTime.month;
      if (selectedMonth == todayMonth && todayDay == selectedDay) {
        int aurita = TimeOfDay.now().hour;
        int horaSeleccionada = time.hour;
        if (horaSeleccionada <= aurita) {
          wrongDataDialog(context, 'La hora no debe ser menor o igual', 0);
          ok=false;
        }
      }
      if (ok){
        String fecha = _dateTime.year.toString()+'-'+_dateTime.month.toString()+'-'+_dateTime.day.toString();
        String hora = time.hour.toString()+':'+time.minute.toString()+':00';
        Reserva unareserva = Reserva(fecha, hora, perID);
        Navigator.pushNamed(context, 'solicitarAtencionReserva', arguments:unareserva);
      }

    } else {
      wrongDataDialog(context, 'Seleccione una fecha y hora valida', 0);
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
        child: ListView(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: littleTitle(
                      'Seleccione le fecha y hora de la atencion',
                      Colors.black),
                )),
            Card(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      child: Text('Fecha de atencion:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ),
                    Expanded(
                        child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                        child: IconButton(
                          focusColor: Colors.yellow,
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: _dateTime == null
                                        ? DateTime.now()
                                        : _dateTime,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2022))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                                formatedDate = formatter.format(_dateTime);
                              });
                            });
                          },
                        ),
                      ),
                      title:
                          Text((formatedDate == null) ? "Fecha" : formatedDate),
                    ))
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      child: Text('Hora de atencion:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ),
                    Expanded(
                        child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                        child: IconButton(
                          focusColor: Colors.yellow,
                          icon: Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            selectTime(context);
                          },
                        ),
                      ),
                      title: Text("${time.hour}:${time.minute}"),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
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
                          "siguiente",
                          style: TextStyle(fontSize: 22),
                        ))),
              ],
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
