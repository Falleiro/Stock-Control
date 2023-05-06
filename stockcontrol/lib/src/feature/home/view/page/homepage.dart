import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/repository/dao/estabelecimento_dao.dart';
import 'package:stock_control/src/feature/home/view/page/stock_create.dart';
import 'package:stock_control/src/feature/home/viewmodel/estabelecimento_viewmodel.dart';
import 'account.dart';
import '../../../../component/personalizados.dart';
import 'localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EstabelecimentoDao _dao = EstabelecimentoDao();
  @override
  Widget build(BuildContext context) {
    _dao.findAll();
    return Scaffold(
      appBar: _minhabarra('appbar-homepage'.i18n(), context),
      body: FutureBuilder<List<Estabelecimento>>(
        initialData: const [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text('clique-no-botao-para-comecar'.i18n())],
                ),
              );
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CircularProgressIndicator(),
                    Text('carregando'.i18n()),
                  ],
                ),
              );
            case ConnectionState.done:
              final List<Estabelecimento> estabelecimentos =
                  snapshot.data ?? [];
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: estabelecimentos.length,
                itemBuilder: (context, int index) {
                  final estabelecimento = estabelecimentos[index];
                  return Linha(
                    text: estabelecimento.name,
                    origem: 'estabelecimento',
                    id: estabelecimento.id,
                  );
                },
              );
            case ConnectionState.active:
              break;
          }
          return Text('unknown-error'.i18n());
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserLocalization()),
                );
              },
              tooltip: 'tooltip-localization'.i18n(),
              child: const Icon(Icons.map),
            ),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserStockCreate(),
                ),
              );
              setState(() {});
            },
            tooltip: 'tooltip-estabelecimento'.i18n(),
            child: const Icon(Icons.add),
          ),
        ],
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserAccount()));
        },
      )
    ],
  );
}
