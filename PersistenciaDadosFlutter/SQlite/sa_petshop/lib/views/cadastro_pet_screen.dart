import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/views/home_screen.dart';

class CadastroPetScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CadastroPetScreenState();
  }
}

class _CadastroPetScreenState extends State<CadastroPetScreen>{
  final _formKey = GlobalKey<FormState>();
  final _petsController = PetControlller();

  String _nome = "";
  String _raca = "";
  String _nomeDono = ""; 
  String _telefone = "";

  _salvarPet() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      final newPet = Pet(
        nome: _nome, 
        raca: _raca, 
        nomeDono: _nomeDono, 
        telefone: _telefone
      );
      await _petsController.createPet(newPet);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen()));
    }
  }

  //buildar a screen 
  @override
  Widget build(BuildContext context) {
  }
}