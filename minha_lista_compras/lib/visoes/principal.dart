import 'package:flutter/material.dart';
import '../dados/dummy_dados.dart';
import '../modelos/produto.dart';
import '../utils/rotas.dart';

class Principal extends StatelessWidget {
  final List<Produto> listaProdutos = DUMMY_PRODUTOS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Minha Lista'),
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemCount: listaProdutos.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(listaProdutos[i].imagemUrl),
                  ),
                  title: Text(listaProdutos[i].descricao),
                  subtitle:
                      Text('Qtde: ${listaProdutos[i].quantidade.toString()}'
                          '   Preço: R\$ ${listaProdutos[i].preco.toString()}'),
                  trailing: PopupMenuButton(
                    itemBuilder: (ctx) => [
                      PopupMenuItem(child: Text('Editar'), value: 1),
                      PopupMenuItem(child: Text('Excluir'), value: 2),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Rotas.FORM_PRODUTO);
          },
          child: Icon(Icons.add),
        ));
  }
}
