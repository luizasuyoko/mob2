import 'package:exemplo2_shared_preferences/tela_cadastro.dart';
import 'package:exemplo2_shared_preferences/tela_inicial.dart';
import 'package:exemplo2_shared_preferences/tela_principal.dart';
import 'package:flutter/material.dart'; // Provides ThemeData and other Material Design components

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => TelaInicial(),
      "/cadastro": (context) => TelaCadastro(),
      "/principal": (context) => TelaPrincipal(),
    },
    theme: ThemeData(brightness: Brightness.light),
    darkTheme: ThemeData(brightness: Brightness.dark)
  ));
}