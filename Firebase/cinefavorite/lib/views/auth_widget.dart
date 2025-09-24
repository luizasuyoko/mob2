import 'package:cinefavorite/views/login_view.dart';
import 'package:cinefavorite/views/procurar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget{
  const AuthWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return ProcurarView();
        }

        return LoginView();
      },
    );
  }
}