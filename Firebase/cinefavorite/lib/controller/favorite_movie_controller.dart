// classe para gerenciar o relacionamento do modelo com a interface

import 'dart:io';

import 'package:cinefavorite/models/favorite_movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FavoriteMovieController {
  //atributos
  final _auth = FirebaseAuth.instance; //conecta com Auth do firebase
  final _db = FirebaseFirestore.instance; //conecta com o firestore

  //criar um user => metodo para buscar o usuario logado
  User? get currentUser => _auth.currentUser;

  //métodos para favorite movie

  //addFavorite => adiciona o filme a lista de favoritos
  void addFavorite(Map<String, dynamic> movieData) async{
    //usar bibliotecas path e path_provide para aremazenar a img no cll
    //baixar a img da internet
    final imagemUrl = "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
    final resposeImg = await http.get(Uri.parse(imagemUrl));
    //armazenar a imagem no dispositivo
    final imagemDir = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemDir.path}/${movieData["id"]}.jpg");
    await imagemFile.writeAsBytes(resposeImg.bodyBytes);

    //criar o obj no database
    final movie = FavoriteMovie(
      id: movieData["id"], 
      title: movieData["title"], 
      posterPath: movieData["poster_path"]
    );
    //adicionar o obj ao firestore 
    await _db.collection("users").doc(currentUser!.uid).collection("favorite_movies").doc(movie.id.toString()).set(movie.toMap());
  }

  //listFavorite => pegar a lista de filmes no db
  //stream => listener, pega a lista de favoritos sempre que for modificada
  Stream<List<FavoriteMovie>> getFavoriteMovies(){
    //verifica se o usuário existe
    if (currentUser ==null) return Stream.value([]); //retorna a lista vazia caso não tenha usuario
      return _db.collection("users").doc(currentUser!.uid).collection("favorite_movies").snapshots().map((snapshot)=> snapshot.docs.map((doc)=>FavoriteMovie.fromMap(doc.data())).toList());
    
  }

  //removeFavorite
  void removeFavorite(int movieId) async {
    if(currentUser == null) return;
    await _db.collection("users").doc(currentUser!.uid).collection("favorite_movies").doc(movieId.toString()).delete();
    
    //deletar a img do diretório
    final imagemPath = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemPath.path}/$movieId.jpg");
    try {
      await imagemFile.delete();
    } catch (e) {
      print("erro ao deletar imagem");
    }
  }

  //updateRating
  void updateRating (int movieId, double rating) async {
    if (currentUser == null) return;
    await _db.collection("users").doc(currentUser!.uid).collection("favorite_movies").doc(movieId.toString()).update({"rating":rating});
  }
}