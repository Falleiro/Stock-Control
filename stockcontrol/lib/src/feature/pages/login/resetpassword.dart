import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 231, 231, 231),
      appBar: AppBar(
        title: Text("redefinir_senha".i18n()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Text(
              "digite_email".i18n(),
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "email".i18n(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _sendNewPassword(_emailController.text);
              },
              child: Text("enviar_senha".i18n()),
            ),
          ],
        ),
      ),
    );
  }

  void _showemailenviadoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(127, 233, 131, 1),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("email_enviado".i18n()),
          content: Text("texto_email_enviado".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 1, milliseconds: 400), () {
      Navigator.of(context).pop();
    });
  }

  void _showemailnaoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 245, 66, 66),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("email_nao_enviado".i18n()),
          content: Text("texto_email_errado".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 1, milliseconds: 750), () {
      Navigator.of(context).pop();
    });
  }

  void _sendNewPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showemailenviadoDialog();
    } catch (e) {
      _showemailnaoDialog();
    }
  }
}
