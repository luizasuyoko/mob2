import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController{
  //metodos 

  //get -all
  Future<List<UsuarioModel>> fetchAll() async{
    final list = await ApiServices.getList("usuarios");
    //retorna a lista de usuarios convertida (json) para usuario model (dart)
    return list.map<UsuarioModel>((item) => UsuarioModel.fromJson(item)).toList();
  }

  //get -one 
  Future<UsuarioModel> fetchOne(String id) async{
    final usuario = await ApiServices.getOne("usuarios", id);
    return UsuarioModel.fromJson(usuario);
  }

  //post 
  Future<UsuarioModel> create(UsuarioModel u) async{
    final created = await ApiServices.post("usuarios", u.toJson());
    //adiiconar o usuario e retorna o usuario adicionado
    return UsuarioModel.fromJson(created);
  }

  //put
  Future<UsuarioModel> update(UsuarioModel u) async{
    final updated = await ApiServices.put("usuarios", u.toJson());
    //retorna o usuario atualizado
    return UsuarioModel.fromJson(updated);
  }

  //delete
  Future<void> delete(String id) async{
    await ApiServices.delete("usuarios", id);
  }
} 