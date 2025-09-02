import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivrosListView extends StatefulWidget {
  const LivrosListView({super.key});

  @override
  State<LivrosListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivrosListView> {
  final _buscarField = TextEditingController();
  List<LivroModel> _livrosFiltrados = [];
  final _controller = LivroController();
  List<LivroModel> _livros = [];
  bool _carregando = true;

  @override
  void initState(){
    super.initState();
    _load();
  }

  _load() async{
    setState(() {
      _carregando = true;
    });
    try{
      _livros = await _controller.fetchAll();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
    setState(() {
      _carregando = false;
    });
  }

  void _filtrar(){
    final busca = _buscarField.text.toLowerCase();
    setState(() {
      _livrosFiltrados = _livros.where((livro){
        return livro.titulo.toLowerCase().contains(busca) ||
        livro.autor.toLowerCase().contains(busca);
      }).toList();
    });
  }

  void _delete(LivroModel livro) async{
    if(livro.id ==  null) return;
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text("Deseja Realmente Excluir o Usuário ${livro.titulo}"),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context, false), child: Text("Cancelar")),
          TextButton(onPressed: ()=>Navigator.pop(context, true), child: Text("Ok"))
        ],
      )
    );
    if(confirme == true){
      try{
        await _controller.delete(livro.id!);
        _load();
      }catch (e){
      }
    }
  }

  void _openForm({LivroModel? livro})async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context)=>LivroFormView(livro:livro)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando
      ? Center(child: CircularProgressIndicator(),)
      : Column(
        children: [
          TextField(
            controller: _buscarField,
            decoration: InputDecoration(labelText: "Pesquisar Livro"),
            onChanged: (value) => _filtrar(),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _livrosFiltrados.length,
              itemBuilder: (context, index){
                final livro = _livrosFiltrados[index];
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: ()=>_openForm(livro: livro),
                      icon: Icon(Icons.edit),
                    ),
                    title: Text(livro.titulo),
                    subtitle: Text(livro.autor),
                    trailing: IconButton(
                      onPressed: ()=> _delete(livro),
                      icon: Icon(Icons.delete, color: Colors.red),)
                    ),
                  );
              }
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}