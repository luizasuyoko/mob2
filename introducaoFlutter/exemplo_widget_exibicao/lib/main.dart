import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp(),));
}

//class de janela
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  //construtor de widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget de Exibição"),),
      body: Center(
        child: Column(
          children: [
            Text("Exemplo de Texto",
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),),
            Text("Texto personalizado",
            style: TextStyle(
              fontSize: 24,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 2,
              decoration: TextDecoration.underline
            ),),
            //icones
            Icon(Icons.star,
            size: 50,
            color: Colors.amber,
            ),
            IconButton(
            onPressed: () => print("Icone Pressionado"), 
            icon: Icon(Icons.add_a_photo,),
            iconSize: 50,
            ),
            //imagens
            Image.network("https://imgs.search.brave.com/Ld1ZWiTvLWFPo5YQ6PXGQMIyJaoT2vj33fbgKtbaxEc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/b2RjZG4uY29tLmJy/L3dwLWNvbnRlbnQv/dXBsb2Fkcy8yMDI0/LzA1L0Rlc3RhcXVl/LUhvbWVtLUFyYW5o/YS1Ob2lyLTY5NXg1/MDAuanBn",
            width: 200,
            height: 200,
            fit: BoxFit.cover,),
            Image.asset('assets/img/image.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover),
            //Box Exibição de Imagem
            Row(
              children: [
                ClipOval(
                  child: Image.asset('assets/img/image.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover),
                ),
                ClipRRect(borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/img/image.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover
                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}