import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/account/redefine_password.dart';
import 'package:stock_control/src/feature/pages/login/loginpage.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
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
        title: Text("appbar-editAccount".i18n()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('Nome do Usuário: ${_user?.displayName ?? ""}'),
            ListTile(
              title: Text(
                "email_logado".i18n(),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                _user?.email ?? "",
                textAlign: TextAlign.center,
              ),
            )
          ],
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
              onPressed: _deleteacount,
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

  void _deleteacount() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              "Tem certeza que quer deletar sua conta? Você irá perder tudo que esta nela."),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
    //await _user?.reauthenticateWithCredential(password as AuthCredential);
  }
}
