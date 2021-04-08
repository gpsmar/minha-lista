import 'package:flutter/foundation.dart';

class Produto {
  final String id;
  final String descricao;
  final int quantidade;
  final double preco;
  final bool comprado;
  final String imagemUrl;

  Produto({
    @required this.id,
    @required this.descricao,
    @required this.quantidade,
    @required this.preco,
    this.comprado = false,
    this.imagemUrl = '',
  });
}
