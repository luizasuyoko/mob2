import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {
  //get all
  Future<List<EmprestimoModel>> fetchAll() async{
    final list = await ApiServices.getList("emprestimos");
    return list.map<EmprestimoModel>((item) => EmprestimoModel.fromJson(item)).toList();
  }

  //get one 
  Future<EmprestimoModel> fetchOne(String id) async{
    final emprestimo = await ApiServices.getOne("emprestimos", id);
    return EmprestimoModel.fromJson(emprestimo);
  }

  //post
  Future<EmprestimoModel> create(EmprestimoModel e) async{
    final created = await ApiServices.post("emprestimos", e.toJson());
    return EmprestimoModel.fromJson(created);
  }

  //put 
  Future<EmprestimoModel> update(EmprestimoModel e) async{
    final updated = await ApiServices.put("emprestimos", e.toJson());
    return EmprestimoModel.fromJson(updated);
  }

  //delete
  Future<void> delete(String id) async {
    await ApiServices.delete("emprestimos", id);
  }
}