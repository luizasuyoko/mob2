import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){ //método principal para rodae a aplicacao
  runApp(MaterialApp( //base d todos os widgets(Elementos visuais)
    home: TelaPerfil(), //tela inicial
    //routes: 

    //} //rotas de navegação
    //theme: , //thema do aplicativo
    //darktheme: , //tema alternativo
    debugShowCheckModeBanner: false, //remove o banner vermelho
  ));
}

class TelaPerfil extends StatefulWidget{ //tela dinamica
  @override
  State<TelaPerfil> createState() => _TelaPerfilState(); //chama a mudança
}

class _TelaPerfilState extends State<TelaPerfil>{//realiza a construção da tela
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();

  String? _nome;
  double? _idade;

  String? _corSelecionada;

  String? _cor;

  Map<String,Color> coresDisponiveis ={
    "Azul": Colors.blue,
    "Verde": Colors.green,
    "Vermelho": Colors.red,
    "Amarelo": Colors.yellow,
    "Cinza": Colors.grey,
    "Preto": Colors.black,
    "Branco": Colors.white,

    Color _corFundo = Colors.white;

    //metodos
    @override
    Void initState(){
      super.initState();
      _carregarPreferencias()
    }

    _carregarPreferencias() async{
      SharedPreferences _prefs =await SharedPreferences.getInstance();
      setState(() {
        _nome = _prefs.getString("nome");
        _idade = _prefs.getDouble("idade");
        _cor = _prefs.getString("cor");
        if(_cor != null){
          _corFundo = coresDisponiveis[_cor!]!;
        }
      });
    }

    _salvarPreferencias( async{
      SharedPreferences_prefs = awaitSharedPreferences.getInstance()
      await _prefs.setString("nome", _nomeController.text.trim());
      await _prefs.setDouble("idade", _idadeController.text.trim());
      await _prefs.setString("cor", _cor ?? "Branco");
      setState(() {})
    })
  };

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(title: Text("Meu Perfil Persistente"), backgroundColor: Colors.purple,)
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Idade"),
              keyboardType: TextInputType.numberWithOptions(), 
            ),
            SizedBox(height:16),
            DropdownButtonFormField(
              value: _cor,
              decoration: InputDecoration(labelText: "Core Favorita"),
              items: coresDisponiveis.keys.map(
                (cor){
                  return DropdownMenuItem(
                    value: _cor,
                    child: Text(cor));
                }
              ).toList(),
              onChanged: (valor){
                setState(() {
                  _cor = valor;
                });
              }SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvarPreferencias, child: Text("Salvar dados")),
              SizedBox: (height: 16),
              Divider(),
              SizedBox: (height: 16),
              Text("Dados Salvos:"),
              if(_nome != null)
                Text("Nome: $_nome"),
              if(_idade != null)
                Text("Idade: $_idade"),
              if(_cor != null)
                Text("Cor: $_cor"),
            )
          ]
        )
      )
    );
  }
}