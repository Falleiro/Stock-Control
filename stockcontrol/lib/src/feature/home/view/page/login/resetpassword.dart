import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();

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
                _sendNewPassword(context, _emailController.text);
              },
              child: Text("enviar_senha".i18n()),
            ),
          ],
        ),
      ),
    );
  }

  void _sendNewPassword(BuildContext context, String email) async {
    final smtpServer = gmail("stockcontrol38@gmail.com", "#Stockcontrol");

    final message = Message()
      ..from = const Address("stockcontrol38@gmail.com")
      ..recipients.add(email)
      ..subject = "Nova senha"
      ..text = "Aqui aparecerá a sua senha";

    try {
      await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('E-mail enviado com sucesso!'),
          duration: const Duration(seconds: 2),
        ),
      );
    } on MailerException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar e-mail: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
