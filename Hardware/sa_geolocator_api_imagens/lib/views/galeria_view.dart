import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GaleriaView extends StatefulWidget{
  const GaleriaView({super.key});

  @override
  State<GaleriaView
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  //vamos manipular imagens da galeria e imagens da camera(arquivos)
  File? _image; //manipular arquivos do Dispositvo
  //cria uma classe de controller para manipular a camera e a galeria 
  final _picker = ImagePicker(); //obj controller de uso da camera/galeria


  //métodos
  //tirar foto
  void _getImageFromCamera() async{
    //abrir a camera e permitir tirar uma foto
    //armazear a foto em um arquivo temporario
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    //verifica se Xfile nao esta vazio
    if (pickedFile != null) {
      setState(() {
        //pega a imagem temporaria e transfere para file:io
        _image = File(pickedFile.path);
      });
    }
  }
  //método para pegar imagem da galeria
  void _getImageFromGallery() async{
    //abrir a camera e permitir tirar uma foto
    //aramazenar a foto em uma arquivo temporario
    final XFile? fotoTemporaria = await _picker.pickImage(source: ImageSource.gallery);
    //verificar se Xfile não esta vazio
    if (fotoTemporaria !=null){
      setState(() {
        //pega a imagem temporaria e tranfere para file:io
        _image = File(fotoTemporaria.path);
      });
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Image Picker"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //mostra a imagem selecionada pelo ImagePicker
            _image != null 
            ? Image.file(_image!, height: 300,)
            : Text("Nenhuma Imagem Selecionado"),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _getImageFromCamera, 
              child: Text("Tirar Foto")),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _getImageFromGallery, 
              child: Text("Escolher da Galeria"))
          ],
        ),
      ),
    );
  }
}