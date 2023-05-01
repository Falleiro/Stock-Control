import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/objectivepage.dart';

// ignore: camel_case_types
class presentationpage extends StatefulWidget {
  const presentationpage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PresentationPageState createState() => _PresentationPageState();
}

class _PresentationPageState extends State<presentationpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 231, 231, 231),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/images/logo.png', height: 120), precisa bolar uma logo
            const SizedBox(height: 16.0),
            Text(
              "app_apresentação".i18n(),
              style: const TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 16, 52, 153)),
            ),

            const SizedBox(height: 16.0),
            Text(
              "texto_apresentação".i18n(),
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ObjectivesScreen()));
              },
              child: Text("proximo".i18n()),
            ),
          ],
        ),
      ),
    );
  }
}
