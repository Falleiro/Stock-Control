import 'package:flutter/material.dart';

import '../../../../component/Personalizados.dart';
import '../widget/stockcreate.dart';

class UserStockCreate extends StatefulWidget {
  final VoidCallback incrementaEstabelecimento;
  const UserStockCreate({super.key, required this.incrementaEstabelecimento});

  @override
  State<UserStockCreate> createState() => _UserStockCreateState();
}

class _UserStockCreateState extends State<UserStockCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Adicionar estabelecimento', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyForm(
              incrementaEstabelecimento: widget.incrementaEstabelecimento,
            )
          ],
        ),
      ),
    );
  }
}

voltaTela(BuildContext context) => Navigator.pop(context);

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 25)),
    elevation: 10,
  );
}

class MyForm extends StatefulWidget {
  final VoidCallback incrementaEstabelecimento;
  const MyForm({super.key, required this.incrementaEstabelecimento});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _cep = TextEditingController();
  final _uf = TextEditingController();
  final _bairro = TextEditingController();
  final _cidade = TextEditingController();
  final _rua = TextEditingController();
  final _numero = TextEditingController();
  final _complemento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        MyTextField(
          myController: _nome,
          fieldName: 'Nome do Estabelecimento',
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _cep,
          fieldName: 'CEP',
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _uf,
          fieldName: 'UF',
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _bairro,
          fieldName: 'Bairro',
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _cidade,
          fieldName: 'Cidade',
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _rua,
          fieldName: 'Rua',
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _numero,
          fieldName: 'Número',
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _complemento,
          fieldName: 'Complemento',
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ]),
    );
  }
}
