import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/produto.dart';
import '../provedores/produtos_provider.dart';

class FormProduto extends StatefulWidget {
  @override
  _FormProdutoState createState() => _FormProdutoState();
}

class _FormProdutoState extends State<FormProduto> {
  final _estadoForm = GlobalKey<FormState>();
  final _mapProdutos = Map<String, Object>();
  bool estaProcessando = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_mapProdutos.isEmpty) {
      final Produto args =
          ModalRoute.of(context)!.settings.arguments as Produto;

      _mapProdutos['id'] = args.id;
      _mapProdutos['descricao'] = args.descricao;
      _mapProdutos['quantidade'] = args.quantidade;
      _mapProdutos['preco'] = args.preco;
      _mapProdutos['imagemUrl'] = args.imagemUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _novoProdutoProv = Provider.of<ProdutosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Produto'),
      ),
      body: Form(
        key: _estadoForm,
        child: estaProcessando
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      //initialValue: _mapProdutos['descricao'].toString(),
                      decoration: InputDecoration(hintText: 'Descrição'),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe a descrição do produto';
                        }
                        return null;
                      },
                      onSaved: (valor) => _mapProdutos['descricao'] = valor!,
                    ),
                    TextFormField(
                      initialValue: _mapProdutos['quantidade'].toString(),
                      decoration: InputDecoration(hintText: 'Quantidade'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      onSaved: (valor) =>
                          _mapProdutos['quantidade'] = int.parse(valor!),
                    ),
                    TextFormField(
                      initialValue: _mapProdutos['preco'].toString(),
                      decoration: InputDecoration(hintText: 'Preço'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      onSaved: (valor) =>
                          _mapProdutos['preco'] = double.parse(valor!),
                    ),
                    TextFormField(
                      initialValue: _mapProdutos['imagemUrl'].toString(),
                      decoration:
                          InputDecoration(hintText: 'Endereço da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onSaved: (valor) => _mapProdutos['imagemUrl'] = valor!,
                      onFieldSubmitted: (str) {
                        if (_estadoForm.currentState!.validate()) {
                          _estadoForm.currentState!.save();

                          setState(() {
                            estaProcessando = true;
                          });

                          final _novoProduto = Produto(
                              id: _mapProdutos['id'].toString().isEmpty
                                  ? Random().nextInt(99999).toString()
                                  : _mapProdutos['id'].toString(),
                              descricao: _mapProdutos['descricao'].toString(),
                              quantidade: int.parse(
                                  _mapProdutos['quantidade'].toString()),
                              preco: double.parse(
                                  _mapProdutos['preco'].toString()),
                              imagemUrl: _mapProdutos['imagemUrl'].toString());

                          if (_mapProdutos['id'].toString().isEmpty) {
                            _novoProdutoProv
                                .adicionaProduto(_novoProduto)
                                .catchError((onError) {
                              return showDialog<Null>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text('Erro inesperado!'),
                                        content: Text(
                                          onError.toString(),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ));
                            }).then(
                              (_) {
                                setState(() {
                                  estaProcessando = false;
                                });
                                Navigator.of(context).pop();
                              },
                            );
                          } else {
                            Navigator.of(context).pop();
                            _novoProdutoProv.atualizaProduto(_novoProduto);
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_estadoForm.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('O produto foi salvo'),
                            ));
                          }
                        },
                        child: Text('Salvar')),
                  ],
                ),
              ),
      ),
    );
  }
}
