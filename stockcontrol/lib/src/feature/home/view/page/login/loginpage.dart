import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/homepage.dart';
import 'package:stock_control/src/feature/home/view/page/login/resetpassword.dart';
import 'package:stock_control/src/feature/home/view/page/login/singuppage.dart';

import '../../../../../services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  late String _email;
  // ignore: unused_field
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 231, 231, 231),
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
                decoration: InputDecoration(labelText: "senha".i18n()),
                obscureText: true,
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
                          builder: (context) => PasswordResetScreen()));
                },
                icon: Text(
                  "esqueci_a_senha".i18n(),
                ),
              ),
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {
                  loginuser(_email, _password);
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
              )
            ],
          ),
        ),
      ),
    );
  }

  loginuser(String emailrec, String passwordrec) async {
    if (!emailrec.contains('@')) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("erro".i18n()),
                content: Text("email_invalido_ou_senha".i18n()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("ok".i18n()),
                  ),
                ],
              ));
    }
    await FirebaseAuthService().signInWithEmailAndPassword(
      email: emailrec,
      password: passwordrec,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
