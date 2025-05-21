//janela de vizualização do app
import 'package:exemplo_sqlite/controllers/nota_controller.dart';
import 'package:exemplo_sqlite/models/nota_model.dart';
import 'package:flutter/material.dart';

class NotaView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NotaViewState();
  }
}

class _NotaViewState extends State<NotaView>{
  final NotaController _controller = NotaController();
  List<Nota> _notas = [];
  bool _isLoading = true;

  //conectar com DB antes de abrir a tela
  @override
  void initState(){
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async{
    setState(() {
      _isLoading = true;
    });
    try{
      _notas = [];
      _notas = await _controller.readNota();
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao Carregar as Notas, $e"),));
    }
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Notas"),),
      body: _isLoading ? 
      Center(
        child: CircularProgressIndicator(),
      ) : 
      Padding(
        padding: EdgeInsets.all(16), 
        child: 
        Expanded(
          child: ListView.builder(
            itemCount: _notas.length,
            itemBuilder: (context, index) {
              final Nota = _notas[index]; //cria um objeto para cada elemento da lista 
              return ListTile(
                title: Text(Nota.titulo),
                subtitle: Text(Nota.conteudo),
                onLongPress: () => _deleteNota(Nota.id),
                onTap: () => _updateNota(Nota),
              );//mostra o objeto na elemento e lista
            },
            )),
      ),
          floatingActionButton: 
          FloatingActionButton(
            onPressed: _addNota,
            tooltip: "Adicionar Nota",
            child: Icon(Icons.add),
          )
        );
  }
  void _addNota() async {
    Nota novaNota = Nota(
      titulo: "Nota ${DateTime.now()}", 
      conteudo: ""
    );
    try {
      await _controller.createNota(novaNota);
      _carregarDados();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Nota Criada com sucesso")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao Salvar a Nota, $e"),));
    }
  }

  void _updateNota (Nota nota) async{
    Nota notaAtualizada = Nota(titulo: "", conteudo: "");
    showDialog(
      context: context, 
      builder: (content) => AlertDialog(
        title: Text("Atualizar Nota"), 
        content: TextField(
          onChanged: (value){
            notaAtualizada = Nota(
              id: nota.id,
              titulo: "${nota.titulo} (Editado)",
              conteudo: value
            );
          }
        )
        actions: [
          TextButton(
            onPressed: (){
              _controller.updateNota(notaAtualizada);
              _carregarDados();
              Navigator.of(context).pop(); //fecha o alertDialog
            },
            child: Text("Atualizar")
          )
        ]
      )
    )
  }

  void _deleteNota(int? id) async{
    try{
      await _controller.deleteNota(id);
      _carregarDados();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nota Deletada com Sucesso")));
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao Deletar Nota, $e")));
    }
  }
}