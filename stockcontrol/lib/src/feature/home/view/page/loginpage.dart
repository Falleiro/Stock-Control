import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/homepage.dart';
import 'package:stock_control/src/feature/home/view/page/singuppage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                controller: _passwordController,
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
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: _loginViewModel.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          await _loginViewModel.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          if (_loginViewModel.user != null) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        }
                      },
                child: _loginViewModel.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
