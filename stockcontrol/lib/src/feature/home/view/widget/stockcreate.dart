import 'package:flutter/material.dart';

import '../../../../component/Personalizados.dart';

class UserStockCreate extends StatefulWidget {
  const UserStockCreate({super.key});

  @override
  State<UserStockCreate> createState() => _UserStockCreateState();
}

class _UserStockCreateState extends State<UserStockCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Adicionar estabelecimento', context),
      body: const Column(
        children: [MyForm()],
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
  const MyForm({super.key});

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
      child: Column(
        children: [
          SizedBox(
            height: 600,
            child: ListView(
              shrinkWrap: true,
              children: [
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  const MyTextField(
      {super.key,
      required this.fieldName,
      required this.myController,
      required this.myIcon,
      required this.prefixIconColor});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Esse espaço precisa ser preenchido';
          } else {
            null;
          }
        },
        controller: widget.myController,
        decoration: InputDecoration(
          labelText: widget.fieldName,
          prefixIcon: Icon(widget.myIcon, color: widget.prefixIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
