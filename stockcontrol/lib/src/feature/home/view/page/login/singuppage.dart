// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:stock_control/src/services/firebase_auth_service.dart';

import '../../../../../services/firebase_auth_service.dart';
import '../homepage.dart';
import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String _name;
  late String _email;
  late String _password;
  late String _confirmPassword;
  late String _birthdate;

  final _auth = FirebaseAuthService(); // instância do FirebaseAuthService

  @override
  Widget build(BuildContext context) {
    const Locale pt = Locale('pt', 'BR');
    const Locale en = Locale('en', 'US');
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 231, 231, 231),
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
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(labelText: "nome".i18n()),
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(labelText: "email".i18n()),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "data_nascimento".i18n()),
                      onChanged: (value) {
                        setState(() {
                          _birthdate = value;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(labelText: "senha".i18n()),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    SizedBox(height: 30),
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
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _email, password: _password);
                          if (newUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        } catch (e) {
                          print(e);
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
    );
  }
}
