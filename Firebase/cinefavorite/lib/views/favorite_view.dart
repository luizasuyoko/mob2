import 'dart:io';

import 'package:cinefavorite/controller/favorite_movie_controller.dart';
import 'package:cinefavorite/models/favorite_movie.dart';
import 'package:cinefavorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _favMovieController = FavoriteMovieController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Filmes Favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut, 
            icon: Icon(Icons.logout))
        ],
      ),
      //a construção da Tela vai depender do conteudo da lista de favoritos 
      body: StreamBuilder<List<FavoriteMovie>>(
        stream: _favMovieController.getFavoriteMovies(), 
        builder: (context, snapshot){
          //se deu erro ao carregar a lista 
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar a lista de favoritos"),);
          }
          //enquanto esta conectando com o firestore
          if (snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          //quando a lista esta vazia 
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum filme adicionado aos favoritos"),);
          }
          //a construção da lista
          final favoriteMovies = snapshot.data!;
          return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8, //espaçamento vertical
                mainAxisSpacing: 8, //espaçamento horizontal
                childAspectRatio: 0.7 //proporção da imagem dentro do grid
                ), 
              itemCount: favoriteMovies.length,
              itemBuilder:(context, index) {
                //criar um obj de favMovies
                final movie = favoriteMovies[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        //criar uma ação para remover o filme dos favoritos quando longpres sobre o filme 
                        child: Image.file(File(movie.posterPath), fit: BoxFit.cover,)
                      ),
                        Center(child: Text(movie.title),),
                        //nota do filme fazer uma ação para alterar a nota do filme
                        Center(child: Text("Nota do Filme: ${movie.rating}"),),
                        //usar estrelas, usar slider, usar barRating
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Slider(
                            value: movie.rating, 
                            min: 0,
                            max: 10,
                            divisions: 20,
                            label: movie.rating.toString(),
                          onChanged: (newRating){
                            setState(() {
                              movie.rating = newRating;
                            });
                            _favMovieController.updateRating(movie.id, newRating);
                          }
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.push(context, MaterialPageRoute(
          builder: (context)=> SearchMovieView())),
        child: Icon(Icons.search),
      ),
    );
  }
}