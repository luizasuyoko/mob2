//Teste de conversão Json <-> Dart
import 'dart:convert'; //nativa -> nao precisa baixar para o pubspec

void main(){
  //tenho um texto em formato de json
  String UsuarioJson = '''{
    "id": "1ab2",
    "user": "usuario1",
    "nome": "Pedro",
    "idade": 25,
    "cadastrado": true
  }''';
  //para manipular o texto
  //converter (decode) Json em Map 
  Map<String, dynamic> usuario =json.decode(UsuarioJson);
  // manipulando informacoes do json -> map
  print(usuario["idade"]);
  usuario["idade"] = 26;
  //converter (encode) de Map -> Json 
  UsuarioJson = json.encode(usuario);
  //tenho novamente um Json em formato de texto
  print(UsuarioJson);
}