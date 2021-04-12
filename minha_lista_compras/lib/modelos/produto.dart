import 'package:flutter/material.dart';

class Produto with ChangeNotifier {
  String id;
  String descricao;
  int quantidade;
  double preco;
  bool comprado;
  String imagemUrl;

  Produto({
    this.id = '',
    this.descricao = '',
    this.quantidade = 0,
    this.preco = 0,
    this.comprado = false,
    this.imagemUrl = '',
  });

  //void setterId(String v) => this.id = v;
}
