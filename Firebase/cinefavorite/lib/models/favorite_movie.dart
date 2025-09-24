//classe de modelagem de dados para movie

class FavoriteMovie {
  //atributos
  final int id; //id do tmdb
  final String title; //título do filme no tmdb
  final String posterPath; //caminho pra imagem do poster
  double rating; //nota que o usuário do app dará para o filme 

  //construtor 
  FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0,
  });

  //métodos de converção de obj <=> Json 

  //toMap
  Map<String, dynamic> toMap() {
    return{
      "id": id,
      "title":title,
      "posterPath": posterPath,
      "rating":rating
    };
  }

  //fromMap
  factory FavoriteMovie.fromMap(Map<String, dynamic> map){
    return FavoriteMovie(
      id: map["id"], 
      title: map["title"], 
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble()
    );
  }
}