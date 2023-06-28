import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/account/redefine_password.dart';
import 'package:stock_control/src/feature/pages/login/loginpage.dart';
import 'package:flutter/services.dart';
import 'package:stock_control/src/feature/repository/app_repository.dart';

//teste
class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User? _user;
  late DatabaseReference _userRef;
  String name = '';
  String birthdate = '';
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _userRef = FirebaseDatabase.instance.ref('users/${_user!.uid}');
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      _userRef.onValue.listen((event) {
        final userData = event.snapshot.value as Map<dynamic, dynamic>?;
        if (userData != null) {
          setState(() {
            // _nameController.text = userData['name'] ?? '';
            // _birthdateController.text = userData['birthdate'] ?? '';
            name = userData['name'] ?? '';
            birthdate = userData['birthdate'] ?? '';
          });
        }
      });
    } catch (error) {
      print('$error');
    }
  }

  void _updateUserData() async {
    if (_nameController.text.isNotEmpty &&
        _birthdateController.text.isNotEmpty) {
      if (!_isNameValid(_nameController.text) ||
          !_isDateValid(_birthdateController.text)) {
        _showInvalidDateNameDialog();
        return;
      }
      if (name != _nameController.text &&
          birthdate != _birthdateController.text) {
        await _userRef.child('name').set(_nameController.text);
        await _userRef.child('birthdate').set(_birthdateController.text);
        _showTemporaryDialog(
            "nome_e_data_alterado".i18n(), Color.fromRGBO(127, 233, 131, 1));
      } else {
        _showigualDialog();
      }
    } else if (_nameController.text.isNotEmpty) {
      if (!_isNameValid(_nameController.text)) {
        _showInvalidNameDialog();
        return;
      }
      if (name != _nameController.text) {
        await _userRef.child('name').set(_nameController.text);
        _showTemporaryDialog(
            "nome_alterado".i18n(), Color.fromRGBO(127, 233, 131, 1));
      } else {
        _showigualDialog();
      }
    } else if (_birthdateController.text.isNotEmpty) {
      if (!_isDateValid(_birthdateController.text)) {
        _showInvalidDateDialog();
        return;
      }
      if (birthdate != _birthdateController.text) {
        await _userRef.child('birthdate').set(_birthdateController.text);
        _showTemporaryDialog(
            "data_alterada".i18n(), Color.fromRGBO(127, 233, 131, 1));
      } else {
        _showigualDialog();
      }
    }
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

  void _showigualDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 245, 66, 66),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("textos_iguais".i18n()),
          content: Text("text_textos_iguais".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 2, milliseconds: 750), () {
      Navigator.of(context).pop();
    });
  }

  void _showInvalidDateNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 245, 66, 66),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("data_nome_invalido".i18n()),
          content: Text("digite_data_nome_valido".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 1, milliseconds: 750), () {
      Navigator.of(context).pop();
    });
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

  void _showTemporaryDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Timer(Duration(seconds: 1, milliseconds: 250), () {
          Navigator.of(context).pop();
        });

        return AlertDialog(
          content: Text(message),
          backgroundColor: color,
        );
      },
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appbar-editAccount".i18n()),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "email_logado".i18n(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    _user?.email ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 153, 149, 149),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "digite_nome".i18n(),
                    hintText: name,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelText: "alterar_data".i18n(),
                    hintText: birthdate,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _DateInputFormatter(),
                  ],
                ),
                SizedBox(height: 55),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateUserData();
                    }
                  },
                  child: Text("salvar_modificacoes".i18n()),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RedefinePassword(),
                    ),
                  );
                },
                child: Text("redefinir_senha".i18n()),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _deleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text("deletar".i18n()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteAccount() async {
    String? errorText;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text("texto_exclusão_conta".i18n()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: "senha_exclusao".i18n(),
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      hintText: "digite_senha".i18n(),
                      errorText: errorText,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text("voltar".i18n()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("ok".i18n()),
                  onPressed: () async {
                    if (_passwordController.text.isEmpty) {
                      setState(() {
                        errorText = "digite_senha".i18n();
                      });
                      return;
                    }

                    try {
                      AuthCredential credential = EmailAuthProvider.credential(
                        email: _user!.email!,
                        password: _passwordController.text,
                      );
                      await _user!.reauthenticateWithCredential(credential);

                      await _userRef.remove();
                      await _user!.delete();
                      _showSnackBar("conta_deletada".i18n(), Colors.green);
                      apagaTudo();
                      Timer(Duration(seconds: 1, milliseconds: 500), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      });
                    } catch (error) {
                      setState(() {
                        errorText = "senha_invalida".i18n();
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
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
