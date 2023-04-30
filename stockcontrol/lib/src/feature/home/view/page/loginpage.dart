import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/home/view/page/homepage.dart';
import 'package:stock_control/src/feature/home/view/page/singuppage.dart';
import 'package:stock_control/src/feature/home/viewmodel/login_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';

//import 'package:flutter/material.dart';
//import 'package:stock_control/viewmodels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha é obrigatória';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
