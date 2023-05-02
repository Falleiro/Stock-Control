import 'dart:async';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/presentationpage.dart';

class LogoPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const presentationpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 231, 231, 231),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.store,
                size: 100, color: Color.fromARGB(255, 6, 90, 187)),
            const SizedBox(height: 10),
            Text(
              "nome_app".i18n(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
