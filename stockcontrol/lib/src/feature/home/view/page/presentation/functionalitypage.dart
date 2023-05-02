import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../login/loginpage.dart';

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
            const Text(
              'Funcionalidades do Aplicativo',
              style: const TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 16, 52, 153)),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Text('Cadastro de produtos'),
                    subtitle: Text(
                        'Adicione produtos ao estoque e mantenha um registro atualizado.'),
                  ),
                  ListTile(
                    title: Text('Controle de estoque'),
                    subtitle: Text(
                        'Acompanhe o estoque dos seus produtos em tempo real.'),
                  ),
                  ListTile(
                    title: Text('Gestão de franquias'),
                    subtitle: Text(
                        'Gerencie suas lojas em diferentes locais e acompanhe as vendas de cada uma.'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("finalizar".i18n()),
            ),
          ],
        ),
      ),
    );
  }
}
