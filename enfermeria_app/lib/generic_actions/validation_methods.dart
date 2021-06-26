bool isNotEmpty(String data){
  if (data != ""){
    String validing = data.replaceAll(' ', '');
    return (validing!="");
  }
  return false;
}

bool isNumeric(String data){
  if(data!=""){
    final numericregex = RegExp(r'^[1-9][0-9]*$');
    return numericregex.hasMatch(data);
  }
  return false;
}