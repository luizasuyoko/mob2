import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  //atributos
  final FirebaseFirestore _db = FirebaseFirestore.instance; //controlador do cloud store 
  final User? _user =  FirebaseAuth.instance.currentUser; //pega as info do usuario conectado
  final TextEditingController _tarefaField = TextEditingController();

  //adicioar tarefa 
  void _addTarefa() async{
    if(_tarefaField.text.trim().isNotEmpty && _user!=null){
      await _db.collection('users').doc(_user!.uid).collection("tarefas").add({
        "titulo": _tarefaField.text.trim(),
        "concluida": false,
        "criadaEm":Timestamp.now()
      });
      _tarefaField.clear();
    }
  }
  //atualizar status da tarefa
  //deletar tarefa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Tarefas"),
        actions: [
          IconButton(onPressed: () async {await FirebaseAuth.instance.signOut();}, 
          icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}