import 'package:flutter/material.dart';

import '../../../../component/Personalizados.dart';
import '../../../../component/my_text_field.dart';

class UserItemCreate extends StatelessWidget {
  const UserItemCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Criar Item', context),
      body: const SingleChildScrollView(
        child: Column(
          children: [MyItemForm()],
        ),
      ),
    );
  }
}

voltaTela(BuildContext context) => Navigator.pop(context);

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 36)),
    elevation: 10,
  );
}

class MyItemForm extends StatefulWidget {
  const MyItemForm({super.key});

  @override
  State<MyItemForm> createState() => _MyItemFormState();
}

class _MyItemFormState extends State<MyItemForm> {
  final _formKey = GlobalKey<FormState>();

  final _nome = TextEditingController();
  final _validade = TextEditingController();
  final _lote = TextEditingController();
  final _adicioanar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        MyTextField(
          myController: _nome,
          fieldName: 'Nome do Item',
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _lote,
          fieldName: 'Lote',
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _validade,
          fieldName: 'Validade',
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _adicioanar,
          fieldName: 'Quantidade que deseja adicionar',
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text('Submit'),
            ),
          ),
        ),
      ]),
    );
  }
}
