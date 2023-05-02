import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/presentation/functionalitypage.dart';

class ObjectivesScreen extends StatelessWidget {
  const ObjectivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 231, 231, 231),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Objetivos do Aplicativo',
              style: TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 16, 52, 153)),
            ),
            SizedBox(height: 16.0),
            const Text(
              'O objetivo principal deste aplicativo é ajudar a gerenciar o estoque da sua empresa, proporcionando maior controle e facilidade no processo de tomada de decisão. Além disso, o aplicativo também pode:',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.timelapse),
                    title: Text('Economizar tempo na gestão de estoque'),
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text('Reduzir custos com desperdício de produtos'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle),
                    title:
                        Text('Melhorar a eficiência na reposição de produtos'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FuncionalidadesScreen()));
              },
              child: Text("proximo".i18n()),
            ),
          ],
        ),
      ),
    );
  }
}
