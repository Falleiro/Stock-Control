import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/homepage.dart';
import 'package:stock_control/src/feature/home/view/page/singuppage.dart';

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
      backgroundColor: Color.fromARGB(248, 168, 170, 172),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "acessar".i18n(),
                style: const TextStyle(
                    fontSize: 40, color: Color.fromARGB(255, 16, 52, 153)),
              ),
              SizedBox(height: 90),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
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
