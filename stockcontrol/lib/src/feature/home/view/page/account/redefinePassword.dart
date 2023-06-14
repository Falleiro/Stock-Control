import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RedefinePassword extends StatefulWidget {
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
          title: Text('Senha redefinida'),
          content: Text('Sua senha foi alterada com sucesso.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redefinição de Senha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(labelText: 'Senha atual'),
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
                decoration: InputDecoration(labelText: 'Nova senha'),
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
                _isLengthValid
                    ? '✓ Pelo menos 6 caracteres'
                    : '× Pelo menos 6 caracteres',
                style: TextStyle(
                    color: _isLengthValid ? Colors.green : Colors.red),
              ),
              Text(
                _isUpperCaseValid
                    ? '✓ Pelo menos uma letra maiúscula'
                    : '× Pelo menos uma letra maiúscula',
                style: TextStyle(
                    color: _isUpperCaseValid ? Colors.green : Colors.red),
              ),
              Text(
                _isNumberValid
                    ? '✓ Pelo menos um número'
                    : '× Pelo menos um número',
                style: TextStyle(
                    color: _isNumberValid ? Colors.green : Colors.red),
              ),
              Text(
                _isSpecialCharValid
                    ? '✓ Pelo menos um caractere especial'
                    : '× Pelo menos um caractere especial',
                style: TextStyle(
                    color: _isSpecialCharValid ? Colors.green : Colors.red),
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirme a nova senha'),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Redefinir Senha'),
                onPressed: _resetPassword,
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
