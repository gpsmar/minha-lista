import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minha_lista_compras/dados/dummy_dados.dart';
import '../modelos/produto.dart';

class ProdutosProvider with ChangeNotifier {
  List<Produto> _produtos = DUMMY_PRODUTOS;

  List<Produto> get produtos => [..._produtos];

  final url = Uri.parse(
    'https://genivaldo-mobile-ab5f8-default-rtdb.firebaseio.com/produtos.json',
  );

  Future adicionaProduto(Produto p) {
    return http
        .post(
      url,
      body: json.encode({
        'id': p.id,
        'descricao': p.descricao,
        'quantidade': p.quantidade,
        'preco': p.preco,
        'comprado': p.comprado,
        'imagemUrl': p.imagemUrl,
      }),
    )
        .then((resposta) {
      if (resposta.statusCode == 200) {
        _produtos.add(p);
        notifyListeners();
      } else {
        throw FlutterError('Código: ${resposta.statusCode}');
      }
    }).catchError((erro) {
      throw erro;
    });
  }

  void removerProduto(String id) {
    _produtos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void atualizaProduto(Produto p) {
    final indice = _produtos.indexWhere((element) => element.id == p.id);

    if (indice >= 0) {
      _produtos[indice] = p;
      notifyListeners();
    }
  }

  Future<void> listaProdutos() async {
    final resposta = await http.get(url);
    print(json.decode(resposta.body));
  }
}
