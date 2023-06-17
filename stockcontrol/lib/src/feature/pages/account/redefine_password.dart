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
          title: const Text('Senha redefinida'),
          content: const Text('Sua senha foi alterada com sucesso.'),
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
      return 'Digite a nova senha';
    }
    if (value.length < 6) {
      _isLengthValid = false;
      return 'A senha deve ter pelo menos 6 caracteres';
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
                decoration: const InputDecoration(labelText: 'Senha atual'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite a senha atual';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'Nova senha'),
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
                ' Pelo menos 6 caracteres',
                style: TextStyle(
                    color: _isLengthValid ? Colors.green : Colors.red),
              ),
              Text(
                ' Pelo menos uma letra maiúscula',
                style: TextStyle(
                    color: _isUpperCaseValid ? Colors.green : Colors.red),
              ),
              Text(
                ' Pelo menos um número',
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
                    const InputDecoration(labelText: 'Confirme a nova senha'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite a confirmação de senha';
                  }
                  if (value != _newPasswordController.text) {
                    return 'As senhas não correspondem';
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
