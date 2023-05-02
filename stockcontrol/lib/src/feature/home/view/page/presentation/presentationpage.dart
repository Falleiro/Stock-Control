import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'objectivepage.dart';

// ignore: camel_case_types
class PresentationPage extends StatefulWidget {
  const PresentationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PresentationPageState createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 231, 231, 231),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0),
            Text(
              "app_apresentação".i18n(),
              style: const TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 16, 52, 153)),
            ),
            const Icon(Icons.store,
                size: 80, color: Color.fromARGB(255, 16, 52, 153)),
            const SizedBox(height: 100.0),
            Text(
              "bem_vindo".i18n(),
              style: const TextStyle(fontSize: 24.0),
              textAlign: TextAlign.left,
            ),
            Text(
              "texto_apresentação".i18n(),
              style: const TextStyle(fontSize: 22.0),
              textAlign: TextAlign.justify,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ObjectivesPage(),
                      ),
                    );
                  },
                  child: Text("proximo".i18n()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
