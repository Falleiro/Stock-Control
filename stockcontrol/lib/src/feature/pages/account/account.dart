import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/account/accout_edit.dart';
import 'package:stock_control/src/feature/pages/login/loginpage.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appbar-account".i18n()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                "email_logado".i18n(),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                _user?.email ?? "",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("sair".i18n()),
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
              child: const Text("deletar"),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: ElevatedButton(
              onPressed: _editAccount,
              child: Text("editar_conta".i18n()),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    final currentContext = context;
    await FirebaseAuth.instance.signOut();
    await Future.delayed(Duration.zero, () {
      Navigator.push(
        currentContext,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  void _editAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditAccount()),
    );
  }

  void _deleteAccount() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tem certeza que quer deletar sua conta?"),
          actions: [
            TextButton(
              child: const Text("Voltar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () async {
                final currentContext = context;
                await _user?.delete();
                await Future.delayed(Duration.zero, () {
                  Navigator.push(
                    currentContext,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
