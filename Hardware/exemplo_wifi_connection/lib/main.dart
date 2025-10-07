import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: WifiStatusScreen(),
  ));
}

class WifiStatusScreen extends StatefulWidget {
  const WifiStatusScreen({super.key});

  @override
  State<WifiStatusScreen> createState() => _WifiStatusScreenState();
}

class _WifiStatusScreenState extends State<WifiStatusScreen> {
  //atributo 
  String _mensagem = ""; //informar o status da conexão 

  //lista que ira amarzenar as mudanças de status
  late StreamSubscription<List<ConnectivityResult>> _conexao;

  //métodos
  void _checkInitialConnection() async {
    ConnectivityResult result = (await Connectivity().checkConnectivity()) as ConnectivityResult;
    _updateConnection(result);
  }

  //método que vai identificar as mudanças de status de conexão 
  void _updateConnection(ConnectivityResult result) async{
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          _mensagem = "Conectado pelo WiFi";
          break;
        case ConnectivityResult.mobile:
          _mensagem = "Conectado via Dados Móveis";
          break;
        case ConnectivityResult.none:
          _mensagem = "Sem conexão com a Internet";
          break;
        default:
        _mensagem = "Procurando Conexão";
      }
    });
  }

  //vai rodar no começo
  @override
  void initState(){
    super.initState();
    //1. faz verificação inicial 
    _checkInitialConnection();
    //2. Começa a ouvir a Mudanças de Status (listener)->stream 
    _conexao = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> results){
        final result = results.isNotEmpty ? results.first :ConnectivityResult.none;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status da Conexão"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //mudar de acordo com a conexao 
            Icon(
              _mensagem.contains("WiFi") ? Icons.wifi : _mensagem.contains("Dados") ? Icons.network_cell : Icons.wifi_off, size: 80, color: _mensagem.contains("Sem conexão") ? Colors.red : Colors.blue,),
              SizedBox(height: 10,),
              Text("Status: $_mensagem")
            ]
            )
      ),
    );
  }
}