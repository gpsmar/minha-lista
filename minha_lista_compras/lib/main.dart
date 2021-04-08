import 'package:flutter/material.dart';
import './visoes/principal.dart';
import './utils/rotas.dart';
import './visoes/form_produto.dart';

void main() {
  runApp(MinhaLista());
}

class MinhaLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Lista',
      home: Principal(),
      routes: {
        Rotas.FORM_PRODUTO: (ctx) => FormProduto(),
      },
    );
  }
}
