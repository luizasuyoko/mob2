import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {
  //get all
  Future<List<LivroModel>> fetchAll() async{
    final list = await ApiServices.getList("livros");
    return list.map<LivroModel>((item) => LivroModel.fromJson(item)).toList();
  }

  //get one 
  Future<LivroModel> fetchOne(String id) async{
    final livro = await ApiServices.getOne("livros", id);
    return LivroModel.fromJson(livro);
  }

  //post
  Future<LivroModel> create(LivroModel l) async{
    final created = await ApiServices.post("livros", l.toJson());
    return LivroModel.fromJson(created);
  }

  //put 
  Future<LivroModel> update(LivroModel l) async{
    final updated = await ApiServices.put("livros", l.toJson());
    return LivroModel.fromJson(updated);
  }

  //delete
  Future<void> delete(String id) async {
    await ApiServices.delete("livros", id);
  }
}