//classe para auxiliar nas chamadas da api 

import 'dart:convert';

class ApiServices{
  //atributos e métodos da classe e não do obj
  //base url para conexão api
  //static -> transforma o atributo em atributo da classe não do obj
  static const String _baseUrl = "http://10.109.197.4";

  //métodos 
  //GET (Listar todos os recursos)
  static Future<List<dynamic>> getList(String path) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path")); //uri-> convert string -> Url
    if(res.statusCode == 200) return json.decode(res.body); //deu certo convert as respostas de json -> List dynamic e final 
    //se não der certo -> gerar um erro
    throw Exception("Falha ao carregar Lista de $path");
  }

  //GET (Listar uum unico recurso)
  static Future<Map<String, dynamic>> getOne(String path, String id) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) return json.decode(res.body);
    //se não deu certo -> Criar erro
    throw Exception("Falha ao Carregar Recurso de $path");
  }

  //POST(Criar novo recurso)
  static Future<Map<String, dynamic>> post(String path, Map<String,dynamic> body) async{
    final res = http.post(
      //endereço da api
      Uri.parse("$_baseUrl/$path"),
      //headers
      headers: {"Content-Type/":"application/json"},
      body: json.encode(body)
    );
    if (res.statusCode == 201) return json.decode(res.body);
    //se nao deu certo
    throw Exception("Falha ao Criar Recurso em $path");
  }

  //PUT(Atualizar recurso)
  static Future<Map<String, dynamic>> put(String path, Map<String,dynamic> body) async{
    final res = http.put(
      //endereço da api
      Uri.parse("$_baseUrl/$path"),
      //headers
      headers: {"Content-Type/":"application/json"},
      body: json.encode(body)
    );
    if (res.statusCode == 200) return json.decode(res.body);
    //se nao deu certo
    throw Exception("Falha ao Criar Recurso em $path");
  }

  //DELETE(Apagar recurso)
  static delete(String path, String id) async{
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode != 200) throw Exception("Falha ao Deletar Recurso $path");
  }
}