import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _birthdate = TextEditingController();
  bool _isUpperCaseValid = false;
  bool _isNumberValid = false;
  bool _isSpecialCharValid = false;
  bool _isLengthValid = false;

  bool checkPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  Future<void> createUser(
      String email, String password, String name, String birthdate) async {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        _isNameValid(name) &&
        _isDateValid(birthdate)) {
      try {
        final userCredential = await FirebaseAuthService()
            .createUserWithEmailAndPassword(email: email, password: password);
        debugPrint('Usuário criado com sucesso: ${userCredential.user!.email}');

        // Salvar nome e data de nascimento no Realtime Database
        final database = FirebaseDatabase.instance;
        final userRef =
            database.reference().child('users').child(userCredential.user!.uid);
        await userRef.set({
          'name': name,
          'birthdate': birthdate,
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        _showemailusadoDialog();
        //debugPrint('Erro ao criar usuário: $e');
      }
    }
    if (!_isNameValid(name)) {
      _showInvalidNameDialog();
    }
    if (!_isDateValid(birthdate)) {
      _showInvalidDateDialog();
    }
    /*
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
    */
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "digite_nova_senha".i18n();
    }
    if (value.length < 6) {
      _isLengthValid = false;
      return "min_caracteres".i18n();
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
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegExp.hasMatch(name);
  }

  bool _isDateValid(String date) {
    final RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    if (regex.hasMatch(date)) {
      List<String> components = date.split('/');
      int day = int.parse(components[0]);
      int month = int.parse(components[1]);
      int year = int.parse(components[2]);

      if (day <= 31 &&
          day > 0 &&
          month > 0 &&
          month <= 12 &&
          year <= 2023 &&
          year >= 1900) {
        return true;
      }
    }

    return false;
  }

  void _showInvalidDateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 245, 66, 66),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("data_invalida".i18n()),
          content: Text("digite_data_valida".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 1, milliseconds: 750), () {
      Navigator.of(context).pop();
    });
  }

  void _showemailusadoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 245, 66, 66),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("email_utilizado".i18n()),
          content: Text("texto_email_utilizado".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 1, milliseconds: 750), () {
      Navigator.of(context).pop();
    });
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
                      controller: _birthdate,
                      decoration: InputDecoration(
                        labelText: "data_nascimento".i18n(),
                        hintText: "adicionar_data".i18n(),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _DateInputFormatter(),
                      ],
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(labelText: "senha".i18n()),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                          validatePassword(value);
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "caracteres".i18n(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: _isLengthValid ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            "letra_maiuscula".i18n(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color:
                                  _isUpperCaseValid ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            "numbers".i18n(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: _isNumberValid ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            "caractere_especial".i18n(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: _isSpecialCharValid
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1),
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
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: () {
                        if (checkPasswordsMatch(_password, _confirmPassword)) {
                          createUser(_email, _password, _name, _birthdate.text);
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
                            ),
                          );
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _formatDate(newValue.text);
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatDate(String text) {
    text = text.replaceAll('/', '');
    if (text.length <= 2) {
      return text;
    } else if (text.length <= 4) {
      return '${text.substring(0, 2)}/${text.substring(2)}';
    } else {
      String year = text.substring(4);
      if (year.length > 4) {
        year = year.substring(0, 4);
      }
      return '${text.substring(0, 2)}/${text.substring(2, 4)}/$year';
    }
  }
}
