
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

//class de janela
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //construtor de widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações")),
      body:  Center(
        child: Column(
          children: [
            Image.network("https://cdn-icons-png.flaticon.com/128/8509/8509176.png",
            width: 200,
            height: 200,
            fit: BoxFit.cover,),
            Text(
              "Nome do Usuário",
              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              "Localização",
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                wordSpacing: 2,
              ),
            ),
            //imagens
            Image.network(
              "https://images.pexels.com/photos/13246954/pexels-photo-13246954.jpeg",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/img/image.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            //Box Exibição de Imagem
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/img/image.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/img/image.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
