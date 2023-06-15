import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/account/redefine_password.dart';
import 'package:stock_control/src/feature/pages/login/loginpage.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
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
              _emailController.text = _user?.email ?? '';
            });
          }
        } as FutureOr Function(DatabaseEvent value))
        .catchError((error) {
      // Lidar com o erro, se houver
      print('Erro ao carregar os dados do usuário: $error');
    });
  }

  void _updateUserData() async {
    await _userRef.update({
      'name': _nameController.text,
      'birthdate': _birthdateController.text,
    });

    try {
      // Atualizar o email
      await _user!.updateEmail(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("dados_atualizados".i18n()),
      ));
    } catch (error) {
      print('Erro ao atualizar o email: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o email'),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                  ),
                  style: TextStyle(
                    color: Colors.black, // Altera a cor do texto para branco
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu nome';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    hintText: 'Digite sua data de nascimento',
                  ),
                  style: TextStyle(
                      color: Colors.black // Altera a cor do texto para branco
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite sua data de nascimento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Digite seu e-mail',
                  ),
                  style: TextStyle(
                    color: Colors.black, // Altera a cor do texto para branco
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu e-mail';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateUserData();
                    }
                  },
                  child: Text("Salvar Alterações"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: ElevatedButton(
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
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: ElevatedButton(
              onPressed: _deleteAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("deletar".i18n()),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAccount() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              "Tem certeza que quer deletar sua conta? Você irá perder tudo que está nela."),
          actions: [
            TextButton(
              child: Text("Voltar".i18n()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK".i18n()),
              onPressed: () async {
                await _user?.delete();
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
