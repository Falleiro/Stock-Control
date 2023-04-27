import 'package:flutter/material.dart';

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

voltaTela(BuildContext context) => Navigator.pop(context);

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 26)),
    elevation: 10,
  );
}
