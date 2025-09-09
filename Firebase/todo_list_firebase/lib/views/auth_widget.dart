//widget de autenticação de usuario => direcionar o usuario logado para as telas de navegação

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';

class AuthWidget extends StatelessWidget{
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //direcionamento de telas dinámicas, 
    //direciona o usuário de acordo com as informações salvas no cache(snapshot)
    return StreamBuilder<User?>( //o stream builder vai depender do usuario existir ou nao  
      stream: FirebaseAuth.instance.authStateChanges(), //modifica o caminho ao mudar o estado do usuario
      builder: (context, snapshot){
        //se snapshot tem dados, significa que o usuario está logado
        if(snapshot.hasData){
          return TarefasView();
        }
        //caso contrario
        return LoginView();
      },
    );
  }
}