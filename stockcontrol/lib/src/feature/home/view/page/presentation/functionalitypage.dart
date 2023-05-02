import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../login/loginpage.dart';
import 'objectivepage.dart';

class FuncionalidadesScreen extends StatelessWidget {
  const FuncionalidadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 231, 231, 231),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.0),
            Text(
              "funcionalidade_app".i18n(),
              style: const TextStyle(
                  fontSize: 36, color: Color.fromARGB(255, 16, 52, 153)),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("cadastro_produto".i18n()),
                    subtitle: Text("texto_cadastro".i18n()),
                  ),
                  ListTile(
                    title: Text("controle_estoque".i18n()),
                    subtitle: Text("texto_controle".i18n()),
                  ),
                  ListTile(
                    title: Text("gestao_estabelecimento".i18n()),
                    subtitle: Text("gestao_texto".i18n()),
                  ),
                  ListTile(
                    title: Text("sugestao_produto".i18n()),
                    subtitle: Text("texto_sugestao".i18n()),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, left: 16.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ObjectivesPage()));
                      },
                      child: Text("voltar".i18n()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text("finalizar".i18n()),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
