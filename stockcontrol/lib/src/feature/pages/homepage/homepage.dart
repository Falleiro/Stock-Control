import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/homepage/widget/my_line.dart';
import 'package:stock_control/src/feature/pages/homepage/widget/button.dart';
import 'package:stock_control/src/feature/repository/dao/estabelecimento_dao.dart';
import 'package:stock_control/src/feature/viewmodel/estabelecimento_viewmodel.dart';
import '../account/account.dart';
import '../../../component/my_appbar.dart';

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  rebuild() {
    setState(() {});
  }

  final EstabelecimentoDao _dao = EstabelecimentoDao();
  @override
  Widget build(BuildContext context) {
    _dao.findAllByUser(widget.userId);
    return WillPopScope(
      onWillPop: () async => false, // Impede o usuário de voltar
      child: Scaffold(
        appBar: _minhabarra('appbar-homepage'.i18n(), context),
        body: FutureBuilder<List<Estabelecimento>>(
          initialData: const [],
          future: _dao.findAllByUser(widget.userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
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
                if (estabelecimentos.isEmpty) {
                  return Center(
                    child: Text(
                      "comeca_inicio".i18n(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: estabelecimentos.length,
                    itemBuilder: (context, int index) {
                      final estabelecimento = estabelecimentos[index];
                      return MyLine(
                        text: estabelecimento.name,
                        id: estabelecimento.id,
                        rebuild: rebuild,
                        cep: estabelecimento.cep,
                        estado: estabelecimento.estado,
                        cidade: estabelecimento.cidade,
                      );
                    },
                  );
                }
              case ConnectionState.active:
                break;
            }
            return Text('unknown-error'.i18n());
          },
        ),
        floatingActionButton: Button(atualizarLista: atualizarLista),
      ),
    );
  }

  Future<void> atualizarLista() async {
    setState(() {});
  }
}

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
