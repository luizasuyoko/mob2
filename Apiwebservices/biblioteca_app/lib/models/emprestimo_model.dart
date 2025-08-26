class EmprestimoModel {
  final String? id;
  final String usuarioId;
  final String livroId;
  final String dataEmprestimo;
  final String dataDevolucao;
  final String devolvido;

  EmprestimoModel({
    this.id,
    required this.usuarioId,
    required this.livroId,
    required this.dataEmprestimo,
    required this.dataDevolucao,
    required this.devolvido
  });

  Map<String, dynamic> toJson() => {
    "id":id,
    "usuarioId": usuarioId,
    "livroId": livroId,
    "dataEmprestimo": dataEmprestimo,
    "dataDevolucao": dataDevolucao,
    "devolvido": devolvido,
  };

  factory EmprestimoModel.fromJson(Map<String, dynamic> json) => EmprestimoModel(
    id: json["id"],
    usuarioId: json["usuarioId"], 
    livroId: json["livroId"], 
    dataEmprestimo: json["dataEmprestimo"], 
    dataDevolucao: json["dataDevolucao"], 
    devolvido: json["devolvido"]);
}