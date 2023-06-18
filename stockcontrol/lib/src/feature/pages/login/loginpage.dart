import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/homepage/homepage.dart';
import 'package:stock_control/src/feature/pages/login/resetpassword.dart';
import 'package:stock_control/src/feature/pages/login/singuppage.dart';
import 'package:stock_control/src/services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailKey = GlobalKey<FormFieldState<String>>();
  final _passwordKey = GlobalKey<FormFieldState<String>>();
  late String _email;
  late String _password;
  bool _showPassword =
      false; // Variável para controlar a exibição dos caracteres da senha

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
                  "acessar".i18n(),
                  style: const TextStyle(
                      fontSize: 40, color: Color.fromARGB(255, 16, 52, 153)),
                ),
                const SizedBox(height: 90),
                TextField(
                  key: _emailKey,
                  decoration: InputDecoration(labelText: "email".i18n()),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                TextField(
                  key: _passwordKey,
                  decoration: InputDecoration(
                    labelText: "senha".i18n(),
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showPassword,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordResetScreen()));
                  },
                  icon: Text(
                    "esqueci_a_senha".i18n(),
                  ),
                ),
                const SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () {
                    if (_email.isNotEmpty && _password.isNotEmpty) {
                      loginuser(_email, _password);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("erro".i18n()),
                          content: Text("campos_obrigatorios".i18n()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("ok".i18n()),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("entrar".i18n()),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  icon: Text(
                    "nao_tem_conta_cadastre".i18n(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginuser(String emailrec, String passwordrec) async {
    try {
      await FirebaseAuthService().signInWithEmailAndPassword(
        email: emailrec,
        password: passwordrec,
      );
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
      String errorMessage;
      if (e.toString().contains('Exception: Senha incorreta.')) {
        errorMessage = "senha_incorreta".i18n();
      } else {
        errorMessage = ("usuario_nao_encontrado".i18n());
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("erro".i18n()),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("ok".i18n()),
              ),
            ],
          );
        },
      );
    }
  }
}
