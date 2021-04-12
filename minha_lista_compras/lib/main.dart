import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './visoes/lista_produto.dart';
import './utils/rotas.dart';
import './visoes/form_produto.dart';
import './provedores/produtos_provider.dart';

void main() {
  runApp(MinhaLista());
}

class MinhaLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProdutosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Minha Lista',
        home: ListaProduto(),
        routes: {
          Rotas.FORM_PRODUTO: (ctx) => FormProduto(),
        },
      ),
    );
  }
}
