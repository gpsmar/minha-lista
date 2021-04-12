import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provedores/produtos_provider.dart';
import '../modelos/produto.dart';
import '../utils/rotas.dart';

class ListaProduto extends StatelessWidget {
  // final List<Produto> lstPrd;
  // ListaProduto(this.lstPrd);

  @override
  Widget build(BuildContext context) {
    final listaProdutos = Provider.of<ProdutosProvider>(context);
    final List<Produto> listagemProdutos = listaProdutos.produtos;
    final listagemHTTP = listaProdutos.listaProdutos();
    return Scaffold(
        appBar: AppBar(
          title: Text('Minha Lista'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemCount: listagemProdutos.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: listagemProdutos[i],
                child: Column(
                  children: [
                    Dismissible(
                      key: UniqueKey(), //ValueKey(listaProdutos[i]),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (_) {
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Confirmação'),
                            content: Text('Deseja realmente apagar o produto?'),
                            actions: [
                              TextButton(
                                child: Text('Não'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                              ),
                              TextButton(
                                child: Text('Sim'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                  listaProdutos
                                      .removerProduto(listagemProdutos[i].id);
                                },
                              )
                            ],
                          ),
                        );
                      },
                      onDismissed: (_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                '${listagemProdutos[i].descricao} removido(a) da lista')));
                      },
                      background: Container(
                        color: Colors.red.shade100,
                        padding: EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete),
                          ],
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          foregroundImage:
                              listagemProdutos[i].imagemUrl.isNotEmpty
                                  ? NetworkImage(listagemProdutos[i].imagemUrl)
                                  : null,
                        ),
                        title: Text(
                          listagemProdutos[i].descricao,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                            'Qtde: ${listagemProdutos[i].quantidade.toString()}'
                            '   Preço: R\$ ${listagemProdutos[i].preco.toString()}'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).pushNamed(Rotas.FORM_PRODUTO,
                                arguments: listagemProdutos[i]);
                            //print(listagemProdutos[i].id);
                          },
                        ),
                      ),
                    ),
                    // Divider(
                    //   indent: 20,
                    //   endIndent: 20,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              Rotas.FORM_PRODUTO,
              arguments: Produto(),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
