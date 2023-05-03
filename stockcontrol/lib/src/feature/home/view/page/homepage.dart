import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/repository/dao/estabelecimento_dao.dart';
import 'package:stock_control/src/feature/home/viewmodel/stockcreate_viewmodel.dart';
import 'account.dart';
import '../../../../component/Personalizados.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EstabelecimentoDao _dao = EstabelecimentoDao();
  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      text: estabelecimento.name, origem: 'estabelecimento');
                },
              );
            case ConnectionState.active:
              break;
          }
          return Text('unknown-error'.i18n());
        },
      ),
      floatingActionButton: MeuFloatingActionButton(),
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
