//formatador de data hora (intl)

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_geolocator_maps/models/location_point.dart';

class PointController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  //solicitar a  localização do dispositivo 
  //método para pegar a localização 
  Future<LocationPoint> getCurrentLocation() async{
    //verificar se as permissoes estao liberadas 
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem acesso ao gps");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão negada de acesso ao gps");
      }
    }

    //acesso liberad
    Position position = await Geolocator.getCurrentPosition();
    String dataHora = _formatar.format(DateTime.now());
    //criar um obj de model
    LocationPoint posicaoAtual = LocationPoint(
      latitude: position.latitude, 
      longitude: position.longitude, 
      dataHora: dataHora
    );
    return posicaoAtual; //devolve o obj criado
  }
}