import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/homepage.dart';
import 'package:stock_control/src/feature/home/view/page/singuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  late String _email;
  // ignore: unused_field
  late String _password;

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 168, 170, 172),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "acessar".i18n(),
                  style: const TextStyle(
                      fontSize: 40, color: Color.fromARGB(255, 16, 52, 153)),
                ),
                SizedBox(height: 90),
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "email".i18n()),
                    validator: (_email) {
                      if (_email == null || _email.isEmpty) {
                        return 'Digite seu e-mail';
                      } else
                        onChanged:
                        (value) {
                          setState(
                            () {
                              _email = value;
                            },
                          );
                        };
                    }),
                SizedBox(height: 30),
                TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(labelText: "senha".i18n()),
                    obscureText: true,
                    validator: (_password) {
                      if (_password == null || _password.isEmpty) {
                        return 'Digite sua senha';
                      } else
                        onChanged:
                        (value) {
                          setState(
                            () {
                              _password = value;
                            },
                          );
                        };
                    }),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  icon: Text(
                    "esqueci_a_senha".i18n(),
                  ),
                ),
                SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
