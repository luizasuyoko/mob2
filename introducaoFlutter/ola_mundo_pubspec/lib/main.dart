import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MyApp());//clase principal da aplicação
}

//criar a classe principal
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Exemplo de Uso do Pubspec"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: (){
            Fluttertoast.showToast(msg: "Olá mundo!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
          }, 
          child: Text("Clique Aqui!")),
        ),
      ),
    );
  }
}