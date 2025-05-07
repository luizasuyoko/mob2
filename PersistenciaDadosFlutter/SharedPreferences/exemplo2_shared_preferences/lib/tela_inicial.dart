import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget{
  const TelaInicial({super.key});
//tela inicial com mudança de estado
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial>{
  //atributos
  String _nome = "";
  String _email = "";
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _darkMode = false; //atributo para o modo escuro
  bool _logado = false; //atributo para verificar se o usuario esta logado

  //métodos
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _carregarPreferencias(); //carregar as preferencias do usuario
    if(_logado){
      Navigator.pushNamed(context, "/principal");
    }
  } 
  _carregarPreferencias() async {
    //conectar com shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString("nome") ?? ""; //carrega as informações da chave nome, caso nmao tenha carrega ""
      _email = prefs.getString("email") ?? "";
      _darkMode = prefs.getBool("darkMode") ?? false;
      _logado = prefs.getBool("logado") ?? false; 
    });
  }

  _trocarTema() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = !_darkMode;
      prefs.setBool("darkMode", _darkMode);
    });
  }

  _logar() async{
    _nome = _nomeController.text.trim();
    _email = _emailController.text.trim();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_nomeController.text.trim().isEmpty || _emailController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preencha todos os Campos!")));
    }else if(prefs.getString(_nome) == _email){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login realizado com sucesso!")));
      prefs.setString("nome", _nome);
      prefs.setBool("logado", true);
      Navigator.pushNamed(context, "/principal");
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login ou Email Inválido!")));
    }
  }

  @override
  Widget build(BuildContext context){
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(), 
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bem-vindo ${_nome =="" ? "Visitante" : _nome}"),
          actions: [
            IconButton(
              onPressed: _trocarTema,
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode)),
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Fazer login", style: TextStyle(fontSize: 20),),
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: "Nome"),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _logar,
            child: Text("Logar"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/cadastro"),
            child: Text("Cadastrar"),
          ),

          ])
        )
      )
    );
  }
}