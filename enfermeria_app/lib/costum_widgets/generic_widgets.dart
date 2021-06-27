import 'package:flutter/material.dart';

Widget bigText(String theText, Color theColor) {
  return Text(theText,
      style: TextStyle(
          color: theColor, fontSize: 40, fontWeight: FontWeight.bold));
}

Widget mediumText(String theText, Color theColor) {
  return Text(theText,
      style: TextStyle(
          color: theColor, fontSize: 32, fontWeight: FontWeight.w600));
}

Widget littleTitle(String theText, Color theColor) {
  return Text(theText,
      style: TextStyle(
          color: theColor, fontSize: 21, fontWeight: FontWeight.w600));
}


Widget normalText(String theText, Color theColor) {
  return Text(theText,
      style: TextStyle(
          color: theColor, fontSize: 24, fontWeight: FontWeight.w600));
}

Widget inputForm(TextEditingController controller, IconData icon, String text) {
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: ListTile(
      leading: Icon(icon),
      title: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: '$text...',
            labelStyle: TextStyle(color: Colors.blue),
            border: OutlineInputBorder()),
      ),
    ),
  );
}

Widget inputFormNumbers(TextEditingController controller, IconData icon, String text) {
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: ListTile(
      leading: Icon(icon),
      title: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
            labelText: '$text...',
            labelStyle: TextStyle(color: Colors.blue),
            border: OutlineInputBorder()),
      ),
    ),
  );
}

Widget inputFormPassword(TextEditingController controller, IconData icon, String text) {
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: ListTile(
      leading: Icon(icon),
      title: TextField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
            labelText: '$text...',
            labelStyle: TextStyle(color: Colors.blue),
            border: OutlineInputBorder()),
      ),
    ),
  );
}

Future<void> wrongDataDialog(
    BuildContext context, String theText, int notiTipo) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(theText,
              style: TextStyle(
                  color: (notiTipo == 1) ? Colors.green : Colors.red)),
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              SimpleDialogOption(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.close),
                  ),
                  onPressed: () => Navigator.pop(context))
            ],
          )),
        );
      });
}