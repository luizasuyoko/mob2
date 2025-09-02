import 'dart:convert'; //pacote dart (ja vem instalado no projeto)
import 'package:flutter/material.dart';
import 'package:json_shared_preferences/tela_inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(
    home: ConfigPage(),
  ));
}

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});


  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {
  //atributos
  bool temaEscuro = false;
  String nomeUsuario = ""; //texto vazio

  //método que roda antes de carregar a pagina
  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  //método para carregar as informações do sharedpreferences
  void carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance(); //conexão com sharedPreferences
    String? jsonString = prefs.getString("config"); //estou recebendo os valores referentes a chave config do sharedpreferences
    if (jsonString != null){
      Map<String, dynamic> config = json.decode(jsonString); 
      setState(() { //método para mudança de estudo
        temaEscuro = config["temaEscuro"] ?? false; //?? operador para elemento null => atribui um valor caso o elemento seja nulo
        nomeUsuario = config["nome"] ?? "";
      });
    }
  }

  //contrução da tela
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de configurações",
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(), //operador ternário
      home: TelaInicial(
        temaEscuro: temaEscuro,
        nomeUsuario: nomeUsuario,
        ),
    );
  }
}