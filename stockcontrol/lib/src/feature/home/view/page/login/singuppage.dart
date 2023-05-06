import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../homepage.dart';
import 'loginpage.dart';
import 'package:stock_control/src/services/firebase_auth_service.dart';
import 'package:stock_control/firebase_options.dart';

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

  bool checkPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

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
                      onPressed: () {
                        if (checkPasswordsMatch(_password, _confirmPassword)) {
                          // try{
                          FirebaseAuthService().createUserWithEmailAndPassword(
                              email: _email, password: _password);
                          // }
                          //mandar _email e _password para a API
                          if (/*se o retorno da API for certo, faça isso*/ _email !=
                              '0') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("erro".i18n()),
                                    content: Text("senha_diferente".i18n()),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
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
