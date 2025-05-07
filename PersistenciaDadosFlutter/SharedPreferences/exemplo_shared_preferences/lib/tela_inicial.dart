//janela inicial do aplicativo
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TelaInicial extends StatefulWidget{
  const TelaInicial({super.key});
 //janela com alteração de estado(SetState)
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

//construção da janela da página 
class _TelaInicialState extends State<TelaInicial>{
  //atributos
  final TextEditingController _nomeController = TextEditingController();
  String _nome = "";
  bool _darkMode = false; 

  //métodos
  @override 
  void initState(){
    super.initState();
    _carregarNome();
  }

  void _salvarPreferencias() async { //método vai rodar de forma assincrona
    if (_nomeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preencha o Nome do Usuário")));
    }else{
      sharedPreferences prefs = await SharedPreferences.getInstance(); // espera estabelece a conexão para pegar a informacao (await)
      _nome = _nomeController.text;
      //salvar no shared preferences a chave/valor
      prefs.setString("nome", _nome);
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nome do Usuário Preenchido")));
        _nomeController.clear();
      });
    }
  }

  void _carregarNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstances();
    setState(() {
      _nome = prefs.getString("nome")?? "";
      _darkMode = prefs.getBool('darkMode' ?? false)
    });
  }

void _mudarTema() async {
  _darkMode = !_darkMode;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBoll("darkMode", _darkMode);
  setState(() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_darkMode ? "Modo Escuro" : "Modo Claro")));
  });
}

  @override
  Widget build(BuildContext context){ //construtor de janela
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bem-vindo ${_nome==""?"Visitate" : _nome}"),
          actions: [
            IconButton(
              onPressed: _mudarTema,
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode),
            )
          ],
        ), //operador ternário
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome do usuário"),
              ),
              ElevatedButton(
                onPressed: _salvarPreferencias, 
                child: Text("Salvar Usuário")
              )
            ],
          )
        )
      ),
    );
  }
}