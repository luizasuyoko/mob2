import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/views/cadastro_pet_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  //atributos
  final _PetController =  PetControlller();
  List<Pet> _pets = []; 
  bool _isLoading = true;

  @override
  void initState() { //metodo para rodar antes de qualquer coisa
    super.initState();
    _carregarDados();
  }

  _carregarDados() async{
    setState(() {
      _isLoading = true;
    });
    try{
      _pets = await _PetController.readPets();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("exception: $e"),));
    } finally{ //execusao obrigatoria
      setState(() {
        _isLoading = false;
      });
    }
  }

  //buildar a tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PetShop - Clientes"),),
      body: _isLoading ? //operador ternario
      Center(
        child: CircularProgressIndicator(), //enquanto estiver carregando as infos da bd, vai mostrar uma barra circular
        ) : 
        Padding(
          padding: EdgeInsets.all(16), //espaçamento da parede do aplicativo de 16px
          child: ListView.builder( //construtor da lista
            itemCount: _pets.length, //tamanho da lista
            itemBuilder: (context, index){ //metodos de construcao
              final pet = _pets[index];
              return ListTile( //item da lista
                title: Text("${pet.nome} - ${pet.raca}"),
                subtitle: Text("${pet.nomeDono} - ${pet.telefone}"),
                //on tap-> para navegar para os detalhes do pet
                //onlongpress -> deletar pet
              ); 
            }
          ),
    ),
    floatingActionButton: FloatingActionButton(
      tooltip: "Adicionar novo pet",
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastroPetScreen())
        );
      }
    ),
  );
  }
}