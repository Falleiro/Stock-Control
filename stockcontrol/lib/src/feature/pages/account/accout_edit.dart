import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/account/redefine_password.dart';
import 'package:stock_control/src/feature/pages/login/loginpage.dart';
import 'package:flutter/services.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  User? _user;
  late DatabaseReference _userRef;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _userRef =
        FirebaseDatabase.instance.reference().child('users').child(_user!.uid);
    _loadUserData();
  }

  void _loadUserData() async {
    _userRef
        .once()
        .then((DataSnapshot snapshot) {
          final userData = snapshot.value as Map<dynamic, dynamic>?;

          if (userData != null) {
            setState(() {
              _nameController.text = userData['name'] as String? ?? '';
              _birthdateController.text =
                  userData['birthdate'] as String? ?? '';
            });
          }
        } as FutureOr Function(DatabaseEvent value))
        .catchError((error) {
      // Handle the error, if any
      print('Error loading user data: $error');
    });
  }

  void _updateUserData() async {
    if (_nameController.text.isNotEmpty) {
      await _userRef.child('name').set(_nameController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Nome alterado com sucesso!'),
      ));
    }
    if (_birthdateController.text.isNotEmpty) {
      await _userRef.child('birthdate').set(_birthdateController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data de aniversário alterada com sucesso!'),
      ));
    }
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
                    'Email logado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    _user?.email ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 129, 124, 124),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelText: 'Data de aniversario',
                    hintText: 'Altere sua data (DD/MM/AAAA)',
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
                  child: Text("Salvar modificações"),
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
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              "Are you sure you want to delete your account? You will lose all your data."),
          actions: [
            TextButton(
              child: Text("Back".i18n()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK".i18n()),
              onPressed: () async {
                // Remover nó do usuário no banco de dados
                await _userRef.remove();

                // Excluir a conta do usuário
                await _user?.delete();

                // Redirecionar para a página de login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
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

  String _formatDate(String value) {
    value = value.replaceAll('/', ''); // Remove all existing slashes
    if (value.length > 8) {
      value = value.substring(0, 8); // Limit to 8 characters
    }
    if (value.length >= 3) {
      value = value.substring(0, 2) + '/' + value.substring(2);
    }
    if (value.length >= 6) {
      value = value.substring(0, 5) + '/' + value.substring(5);
    }
    return value;
  }
}
