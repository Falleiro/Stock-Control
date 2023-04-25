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
      body: const ListViewBuilder(),
      floatingActionButton: MeuFloatingActionButton(),
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

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 6,
        itemBuilder: (BuildContext, int index) {
          return Linha();
        });
  }
}

class MeuFloatingActionButton extends StatelessWidget {
  const MeuFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 24),
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            tooltip: 'Vai para a tela de localização',
            child: const Icon(Icons.map),
          ),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {},
          tooltip: 'Vai para a tela "Cria Estabelecimento" ',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
