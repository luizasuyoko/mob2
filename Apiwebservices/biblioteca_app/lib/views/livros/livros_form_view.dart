import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivrosFormView extends StatefulWidget{
  final LivroModel? livro;

  const LivrosFormView({super.key, this.livro});

  @override
  State<StatefulWidget> createState() => _LivroFormViewtState();
}

class _LivroFormViewtState extends State<UsuarioFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LivroController();
  final _tituloField = TextEditingController();
  final _autorField = TextEditingController();
  final _disponivel = 

  @override
  void initState() {
    super.initState();
    if(widget.livro != null){
      _tituloField.text = widget.livro!.titulo;
      _autorField.text = widget.livro!.autor;
    }
  }

  void _criar() async{
    if(_formKey.currentState!.validate()){
      final livroNovo = LivroModel(
        id: DateTime.now().millisecond.toString(),
        titulo: _tituloField.text.trim(), 
        autor: _autorField.text.trim(), 
        disponivel: _)
    }
  }
}