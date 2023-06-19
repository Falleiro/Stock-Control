import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/account/account.dart';

class RedefinePassword extends StatefulWidget {
  const RedefinePassword({super.key});

  @override
  _RedefinePasswordState createState() => _RedefinePasswordState();
}

class _RedefinePasswordState extends State<RedefinePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _errorMessage = '';
  bool _isUpperCaseValid = false;
  bool _isNumberValid = false;
  bool _isSpecialCharValid = false;
  bool _isLengthValid = false;

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: _currentPasswordController.text,
          );
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(_newPasswordController.text);
          _showSuccessDialog();
        } on FirebaseAuthException catch (e) {
          setState(() {
            _errorMessage = e.message!;
          });
        }
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("senha_redefinida".i18n()),
          content: Text("senha_alterada".i18n()),
          actions: <Widget>[
            TextButton(
              child: Text("OK".i18n()),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserAccount()));
              },
            ),
          ],
        );
      },
    );
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "digite_nova_senha".i18n();
    }
    if (value.length < 6) {
      _isLengthValid = false;
      return "min_caracteres".i18n();
    } else {
      _isLengthValid = true;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("redefinir_senha".i18n()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(labelText: "senha_atual".i18n()),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "digite_senha_atual".i18n();
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: "nova_senha".i18n()),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    validatePassword(value);
                  });
                },
                validator: (value) {
                  return validatePassword(value!);
                },
              ),
              Text(
                "caracteres".i18n(),
                style: TextStyle(
                    color: _isLengthValid ? Colors.green : Colors.red),
              ),
              Text(
                "letra_maiuscula".i18n(),
                style: TextStyle(
                    color: _isUpperCaseValid ? Colors.green : Colors.red),
              ),
              Text(
                "numbers".i18n(),
                style: TextStyle(
                    color: _isNumberValid ? Colors.green : Colors.red),
              ),
              Text(
                "caractere_especial".i18n(),
                style: TextStyle(
                    color: _isSpecialCharValid ? Colors.green : Colors.red),
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration:
                    InputDecoration(labelText: "confirme_nova_senha".i18n()),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "confirmacao_senha".i18n();
                  }
                  if (value != _newPasswordController.text) {
                    return "senha_diferentes".i18n();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text("redefinir_senha".i18n()),
              ),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
