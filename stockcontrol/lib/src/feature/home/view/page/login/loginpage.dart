import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/homepage.dart';
import 'package:stock_control/src/feature/home/view/page/login/singuppage.dart';
import 'package:stock_control/src/common/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  late String _email;
  // ignore: unused_field
  late String _password;
  final AuthService _authService = AuthService();

  bool _validateInputs() {
    // Verifica se o email e a senha são válidos
    if (_email == null || _email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, digite um email válido.")),
      );
      return false;
    } else if (_password == null || _password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, digite uma senha válida.")),
      );
      return false;
    }
    return true;
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
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                icon: Text(
                  "esqueci_a_senha".i18n(),
                ),
              ),
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () {
                  if (_validateInputs()) {
                    // Navega para a página inicial se as informações de login são válidas
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
