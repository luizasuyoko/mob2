// ignore_for_file: unused_field

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: TelaCadastroApp(),));
}

//criar uma tela de cadastro (formulário)
class TelaCadastroApp extends StatefulWidget{
  const TelaCadastroApp({super.key});

  @override
  _TelaCadastroAppState createState() => _TelaCadastroAppState();
}

class _TelaCadastroAppState extends State<TelaCadastroApp> {
  //atributos
  final _formKey = GlobalKey<FormState>(); //chave de seleção dos componentes do formulario
  String _nome = ""; //tulização do "_" antes da declaração da variável (private)
  String _email = "";
  String _senha = "";
  String _genero = "";
  String _dataNascimento = "";
  double _experiencia = 0;
  bool _aceite = false; 
  bool _senhaOculta = true;//declaração da boolean (bool)

  //métodos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de usuário - Exemplo Widget Interação")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //campo para colocar o nome
              TextFormField(
                decoration: InputDecoration(labelText: "Insira o Nome"),
                validator: (value)=> value!.isEmpty ? "Digite um Nome" : null, //operador ternário
                onSaved: (value)=> _nome = value!,  
              ),
              SizedBox(height: 15,),
              //Campo Email
              TextFormField(
                decoration: InputDecoration(labelText: "Insira seu E-mail"),
                validator: (value)=> value!.contains("@") ? null: "Digite um E-mail Válido",
                onSaved: (value)=> _email = value!,
              ),
              SizedBox(height: 15,),
              //campo senha
              TextFormField(
                decoration: InputDecoration(labelText: "Insira sua Senha",
                prefixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _senhaOculta = !_senhaOculta;
                    });
                  },
                  icon: Icon(Icons.lock))),
                obscureText: _senhaOculta,
                validator: (value)=> value!.trim().length>=6 ? null:"Digite uma Senha Válida",
                onSaved: (value)=> _senha = value!.trim(),
              ),
              SizedBox(height: 15,),
              Text("Gênero"),
              DropdownButtonFormField(
                items: ["Feminino", "Masculino", "Outro"].map((String genero)=>DropdownMenuItem(value: genero, child: Text(genero))).toList(), 
                onChanged: (value){},
                validator: (value)=> value==null ? "Selecione um Gênero": null,
                onSaved: (value)=> _genero = value!,
              ),
              SizedBox(height: 15,),
              //campo datanascimento
              TextFormField(
                decoration: InputDecoration(labelText: "Digite a Data de Nascimento"),
                validator: (value)=> value!.trim().isEmpty ? "Digite a Data de Nascimento" : null,
                onSaved: (value)=> _dataNascimento = value!.trim(),
              ),
              SizedBox(height: 15,),
              //slider de seleção
              Text("Anos de Expêriencia com Programação: "),
              Slider(
                value: _experiencia,
                min: 0,
                max: 20,
                divisions: 20,
                label: _experiencia.round().toString(), 
                onChanged: (value)=>setState(() {
                  _experiencia = value;
                })),
                CheckboxListTile(
                  value: _aceite,
                  title: Text("Aceito os termos de uso do aplicativo"), 
                  onChanged: (value)=>setState(() {
                    _aceite = value!;
                  })), 
                  SizedBox(height: 15,),
                  //aceite dos termos de uso
                  CheckboxListTile(
                    value: _aceite, 
                    title: Text("Aceite os termos de Uso do Aplicativo"),
                    onChanged: (value)=>setState(() {
                      _aceite = value!;
                    }),
                    ),
                  //botao de envio do formulario 
                  ElevatedButton(
                    onPressed: _enviarFormulario, 
                    child: Text("Enviar"))
              ],
          ),)
    ));
  }

  void _enviarFormulario() {
    if(_formKey.currentState!.validate()&& _aceite){
      _formKey.currentState!.save();
      showDialog(
        context: context, 
        builder: (context)=>AlertDialog(
          title: Text("Dados fo Formulário"),
          content: Column(
            children: [
              Text("Nome: $_nome"),
              Text("Email: $_email")
            ],
          ),
        ));
    }
  }
}