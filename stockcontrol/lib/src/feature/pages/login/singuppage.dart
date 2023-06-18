import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:localization/localization.dart';
import '../homepage/homepage.dart';
import 'loginpage.dart';
import 'package:stock_control/src/services/firebase_auth_service.dart';

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
  bool _isUpperCaseValid = false;
  bool _isNumberValid = false;
  bool _isSpecialCharValid = false;
  bool _isLengthValid = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool checkPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  Future<void> createUser(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("erro".i18n()),
          content: Text("email_senha_obrigatorio".i18n()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ok".i18n()),
            ),
          ],
        ),
      );
      return;
    }

    try {
      if (!_isNameValid(_name)) {
        _showInvalidNameDialog();
        return;
      }
      final userCredential = await FirebaseAuthService()
          .createUserWithEmailAndPassword(email: email, password: password);
      debugPrint('Usuário criado com sucesso: ${userCredential.user!.email}');

      // Salvar nome e data de nascimento no Realtime Database
      final database = FirebaseDatabase.instance;
      final userRef =
          database.reference().child('users').child(userCredential.user!.uid);
      await userRef.set({
        'name': _name,
        'birthdate': _birthdate,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      debugPrint('Erro ao criar usuário: $e');
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Digite a nova senha';
    }
    if (value.length < 6) {
      _isLengthValid = false;
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    _isLengthValid = true;
    if (value.contains(RegExp(r'[A-Z]'))) {
      _isUpperCaseValid = true;
    } else {
      _isUpperCaseValid = false;
    }
    if (value.contains(RegExp(r'[0-9]'))) {
      _isNumberValid = true;
    } else {
      _isNumberValid = false;
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _isSpecialCharValid = true;
    } else {
      _isSpecialCharValid = false;
    }
    return null;
  }

  bool _isNameValid(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
    return nameRegExp.hasMatch(name);
  }

  void _showInvalidNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 245, 66, 66),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("nome_invalido".i18n()),
          content: Text("letras_no_nome".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 1, milliseconds: 750), () {
      Navigator.of(context).pop();
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  TextFormField buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "senha".i18n(),
        suffixIcon: IconButton(
          onPressed: togglePasswordVisibility,
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      obscureText: !_isPasswordVisible,
      onChanged: (value) {
        setState(() {
          _password = value;
          validatePassword(value);
        });
      },
    );
  }

  TextFormField buildConfirmPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "repita_senha".i18n(),
        suffixIcon: IconButton(
          onPressed: toggleConfirmPasswordVisibility,
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      obscureText: !_isConfirmPasswordVisible,
      onChanged: (value) {
        setState(() {
          _confirmPassword = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Impede o usuário de voltar
      child: Scaffold(
        backgroundColor: Color.fromARGB(248, 231, 231, 231),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  "criar_nova_conta".i18n(),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 16, 52, 153),
                  ),
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
                    SizedBox(height: 25),
                    buildPasswordTextField(),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pelo menos 6 caracteres',
                            style: TextStyle(
                              color: _isLengthValid ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            'Pelo menos uma letra maiúscula',
                            style: TextStyle(
                              color:
                                  _isUpperCaseValid ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            'Pelo menos um número',
                            style: TextStyle(
                              color: _isNumberValid ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            'Pelo menos um caractere especial',
                            style: TextStyle(
                              color: _isSpecialCharValid
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    buildConfirmPasswordTextField(),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (checkPasswordsMatch(
                              _password, _confirmPassword)) {
                            createUser(_email, _password);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("senhas_nao_coincidem".i18n()),
                                content: Text("verifique_senhas".i18n()),
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
                        child: Text("cadastrar".i18n()),
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "ja_tem_conta".i18n(),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
