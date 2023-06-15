// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../homepage/homepage.dart';
import 'loginpage.dart';
import 'package:stock_control/src/services/firebase_auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String _name;
  late String _email;
  late String _password;
  late String _confirmPassword;
  late String _birthdate;

  bool checkPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  // ignore: non_constant_identifier_names
  creatuser(String emailrec, String passwordrec) async {
    if (emailrec.isEmpty || passwordrec.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("erro".i18n()),
                content: Text("email_senha_origatorio".i18n()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("ok".i18n()),
                  ),
                ],
              ));
    }
    if (!emailrec.contains('@')) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("erro".i18n()),
                content: Text("email_invalido".i18n()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("ok".i18n()),
                  ),
                ],
              ));
    }
    if (passwordrec.length < 6) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("erro".i18n()),
                content: Text("rec_senha".i18n()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("ok".i18n()),
                  ),
                ],
              ));
    }
    try {
      final userCredential =
          await FirebaseAuthService().createUserWithEmailAndPassword(
        email: emailrec,
        password: passwordrec,
      );
      debugPrint('Usuário criado com sucesso: ${userCredential.user!.email}');
      final currentContext = context;
      Future.delayed(
        Duration.zero,
        () {
          Navigator.push(
            currentContext,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('Erro ao criar usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Impede o usuário de voltar
      child: Scaffold(
        backgroundColor: const Color.fromARGB(248, 231, 231, 231),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    "criar_nova_conta".i18n(),
                    style: const TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 16, 52, 153)),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(labelText: "nome".i18n()),
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(labelText: "email".i18n()),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "data_nascimento".i18n()),
                        onChanged: (value) {
                          setState(() {
                            _birthdate = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(labelText: "senha".i18n()),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: "repita_senha".i18n()),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                      ),
                      const SizedBox(height: 60.0),
                      ElevatedButton(
                        onPressed: () {
                          if (checkPasswordsMatch(
                              _password, _confirmPassword)) {
                            creatuser(_email, _password);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("erro".i18n()),
                                      content: Text("senha_diferente".i18n()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("ok".i18n()),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        child: Text("cadastrar".i18n()),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    iconSize: 50,
                    icon: Text(
                      "ja_tem_conta_acesse_aqui".i18n(),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
