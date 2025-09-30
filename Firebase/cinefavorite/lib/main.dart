import 'package:cinefavorite/firebase_options.dart';
import 'package:cinefavorite/views/favorite_view.dart';
import 'package:cinefavorite/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{ //na main é estabelecida  uma conexão com o firebase
  //garantir o carregamento dos widgets
  WidgetsFlutterBinding.ensureInitialized();
  //conectar com o firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    title: "Cine Favorite",
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
    ),
    home: AuthStream(), //permite a navegação de tela de acordo com algum decisão
  ));
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>( //permitir retorno null para usuário?
      //listener = ouvinte da mudança de status do usuário
      stream: FirebaseAuth.instance.authStateChanges(),
      //identifica a mudança de status de usuario (logado ou não)
      builder: (context, snapshot){ //analisa a instantânea da aplicação
        //se tiver logado vai para a tela de favoritos
        if(snapshot.hasData){
          return FavoriteView();
        } //caso contrario => tela de login
        return LoginView();
      },
    );
  }
}