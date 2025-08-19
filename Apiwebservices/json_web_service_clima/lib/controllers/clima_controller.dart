import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/models/clima_models.dart';

class ClimaController {
  final String _apikey = "e584ba76ab16ad2e2ee3d35922e0c67f";

  //método para pegar a informação do clima de uma cidade 
  //método get
  Future<ClimaModel?> buscarClima(String cidade) async {
  final url = Uri.parse(
    "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apikey&unit=metric"
  );
  final response = await http.get(url);
  if(response.statusCode == 200){
    final dados = json.decode(response.body);
    return ClimaModel.fromJson(dados);
  }else{
    return null;
  }
  }
}