import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../../component/Personalizados.dart';

class UserStock extends StatefulWidget {
  final String estabelecimento;
  const UserStock({super.key, required this.estabelecimento});

  @override
  State<UserStock> createState() => _UserStockState();
}

class _UserStockState extends State<UserStock> {
  int _qtd = 1;
  String _text = 'Item ';
  void _incrementaItem() {
    setState(() {
      _qtd++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Itens - ${widget.estabelecimento}', context),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _qtd,
        itemBuilder: (BuildContext, int index) {
          String text = '$_text${index + 1}';
          return Linha(text: text, origem: 'item');
        },
      ),
    );
  }
}

//Criando algoritmo para sugerir itens em estabelecimento de acordo com a quantidade de itens vendidos
class Item {
  String nome;
  int quantidade; //quantidade produto
  Item(this.nome, this.quantidade);
}

class Estabelecimento {
  String nome;
  List<Item>
      itemVendido; // lembrar de fazer a logica de produto vendido.... o que foi decrementado do estoque atual
  Estabelecimento(this.nome, this.itemVendido);
}
/*
logica do item vendido...
if(estoqueAtualizado){ criar uma condição que ao atualizar o valor do estoque retorna true, para essa variavel "estoqueAtualizado"
  if(quantidadeEstoqueAtualItem > quantidadeEstoqueAtualizado ) se a quantidade de itens atuais no estoque for maior que a quantidsade após o estoque atualizar... significa que foi vendido
  itemVendido = quantidadeEstoqueAtualItem - quantidadeEstoqueAtualizado;
}else{
  return
}
*/

// Criando uma lista de estabelecimentos com os produtos vendidos
List<Estabelecimento> estabelecimentos = [
  Estabelecimento("Estabelecimento 1", [
    Item("Arroz",
        100), //no lugar do "arroz" tem que ser o item criado pelo usuario, o inteiro após dele é a quantidade qeu ele foi vendido, que tem que obter pela logica acima.
    Item("Feijão", 50),
    Item("Leite", 75),
  ]),
  Estabelecimento("Estabelecimento 2", [
    Item("Arroz", 80),
    Item("Feijão", 60),
    Item("Leite", 100),
  ]),
  Estabelecimento("Estabelecimento 3", [
    Item("Arroz", 120),
    Item("Feijão", 70),
    Item("Leite", 50),
  ]),
];

// Função que retorna uma lista de produtos sugeridos com base nas vendas de cada estabelecimento
// ignore: non_constant_identifier_names
List<Item> ItensSugeridos(String nomeEstabelecimento) {
  // Procura o estabelecimento com o nome informado
  Estabelecimento estabelecimento =
      estabelecimentos.firstWhere((f) => f.nome == nomeEstabelecimento);

  // lista vazia para armazenar os produtos sugeridos
  List<Item> itensSugeridos = [];

  // Percorre cada produto vendido em cada estabelecimento
  for (Item itemVendido in estabelecimento.itemVendido) {
    // Calcula a quantidade média vendida desse produto em todos os estabelecimentos
    int quantidadeMedia = 0;
    for (Estabelecimento f in estabelecimentos) {
      if (f != estabelecimento) {
        Item p = f.itemVendido.firstWhere((p) => p.nome == itemVendido.nome);
        quantidadeMedia += p.quantidade;
      }
    }
    quantidadeMedia ~/= estabelecimentos.length - 1;

    // Se a quantidade vendida do estabelecimento atual for menor do que a quantidade média em todos os estabelecimentos, o produto é sugerido
    if (itemVendido.quantidade < quantidadeMedia) {
      itensSugeridos.add(
          Item(itemVendido.nome, quantidadeMedia - itemVendido.quantidade));
    }
  }
  return itensSugeridos;
}

void main() {
  // cria uma lista de produtos sugeridos para o estabelecimento 1
  List<Item> itensSugeridos = ItensSugeridos("estabelecimento 1");

  // Imprime a lista de produtos sugeridos
  Text("item_sugerido".i18n());
  for (Item p in itensSugeridos) {
    print("${p.nome}: ${p.quantidade}");
  }
}

voltaTela(BuildContext context) => Navigator.pop(context);

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 26)),
    elevation: 10,
  );
}
