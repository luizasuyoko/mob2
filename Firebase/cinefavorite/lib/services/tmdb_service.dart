//meu serviço de conexão com api tmdb

import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbService {
  //colocar dados da api
  static const String _apiKey = "";
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";
  //static -> atributos é da classe e não do obj

  //método static => metodo da classe -> não precisa instanciar obj
  //para acessar o metodo

  //buscar filme na api pelo tema
  static Future<List<Map<String, dynamic>>> searchMovie(String termo)async {
    //converter string em url
    final apiURI = Uri.parse("$_baseUrl/search/movie?api_key=$_apiKey&query=$termo&language=$_idioma");
    //http request - get
    final response = await http.get(apiURI);

    //verificar a resposta 
    if(response.statusCode==200){
      //converter a resposta json para dart
      final data = json.decode(response.body);
      //transformar data(string) em list<Map>
      return List<Map<String, dynamic>>.from(data["results"]); 
    }else{ //caso contrário statuscode != 200
      //criar uma exception
      throw Exception("Falha ao carregar filmes da API");
    }
  } 

  //criar outros métodos de busca para API
  
}