import 'package:flutter/material.dart';

import '../widget/account.dart';
import '../../../../component/Personalizados.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Stock Control', context),
      body: ListView(
        children: const [
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
          Linha(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 24),
            child: FloatingActionButton(
              onPressed: () => setState(() {}),
              tooltip: 'Vai para a tela "Cria Estabelecimento" ',
              child: const Icon(Icons.map),
            ),
          ),
          FloatingActionButton(
            onPressed: () => setState(() {}),
            tooltip: 'Vai para a tela "Cria Estabelecimento" ',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 36)),
    elevation: 10,
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.account_circle,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserAccount()));
        },
      )
    ],
  );
}
