import 'dart:math';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/loginpage.dart';
import 'homepage.dart';
import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String _email;
  late String _password;
  late String _confirmPassword;
  late String _birthdate;

  @override
  Widget build(BuildContext context) {
    const Locale pt = Locale('pt', 'BR');
    const Locale en = Locale('en', 'US');
    return Scaffold(
      appBar: AppBar(
        title: Text("criar_nova_conta".i18n()),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Locale(pt as String);
                      },
                      icon: const Text("pt"),
                    ),
                    IconButton(
                      onPressed: () {
                        Locale(pt as String);
                      },
                      icon: const Text("en"),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "email".i18n()),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "senha".i18n()),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
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
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "data_nascimento".i18n()),
                      onChanged: (value) {
                        setState(() {
                          _birthdate = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: Text("cadastrar".i18n()),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      icon: Text(
                        "ja_tem_conta_acesse_aqui".i18n(),
                        // style: TextStyle(height: 500),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
