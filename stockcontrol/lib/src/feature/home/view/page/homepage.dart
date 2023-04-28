import 'package:flutter/material.dart';
import 'account.dart';
import '../../../../component/Personalizados.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _qtd = 1;
  String _text = 'Estabelecimento ';
  void _incrementaEstabelecimento() {
    setState(() {
      _qtd++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Stock Control', context),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _qtd,
        itemBuilder: (BuildContext, int index) {
          String text = '$_text${index + 1}';
          return Linha(text: text, origem: 'estabelecimento');
        },
      ),
      floatingActionButton: MeuFloatingActionButton(
        incrementaEstabelecimento: _incrementaEstabelecimento,
      ),
    );
  }
}

//APP BAR
PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    automaticallyImplyLeading: false,
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
