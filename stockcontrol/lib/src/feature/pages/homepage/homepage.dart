import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/homepage/widget/my_line.dart';
import 'package:stock_control/src/feature/pages/homepage/widget/button.dart';
import 'package:stock_control/src/feature/repository/dao/estabelecimento_dao.dart';
import 'package:stock_control/src/feature/viewmodel/estabelecimento_viewmodel.dart';
import '../account/account.dart';
import '../../../component/my_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  late DatabaseReference _userRef;
  rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _userRef = FirebaseDatabase.instance.ref('users/${_user!.uid}');
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      _userRef.onValue.listen((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          setState(() {
            data['name'] ?? '';
            data['birthdate'] ?? '';
          });
        }
      });
    } catch (error) {
      print('$error');
    }
  }

  final EstabelecimentoDao _dao = EstabelecimentoDao();
  @override
  Widget build(BuildContext context) {
    _dao.findAll();
    return WillPopScope(
      onWillPop: () async => false, // Impede o usuário de voltar
      child: Scaffold(
        appBar: _minhabarra('appbar-homepage'.i18n(), context),
        body: FutureBuilder<List<Estabelecimento>>(
          initialData: const [],
          future: _dao.findAll(),
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
