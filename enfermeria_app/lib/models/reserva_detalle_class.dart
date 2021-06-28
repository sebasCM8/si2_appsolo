import 'package:enfermeria_app/models/reserva_class.dart';
import 'package:enfermeria_app/models/servicio_class.dart';

class ReservaDetalle{
  Reserva res;
  List<Servicio> servicios;
  ReservaDetalle(this.res, this.servicios);
}