import 'package:flutter/material.dart';
import 'package:stock_control/src/feature/home/repository/dao/estabelecimento_dao.dart';
import 'package:stock_control/src/feature/home/viewmodel/stockcreate_viewmodel.dart';

import '../../../../component/Personalizados.dart';
import '../widget/stockcreate.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [MyForm()],
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
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final EstabelecimentoDao _dao = EstabelecimentoDao();
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
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final Estabelecimento newEstabelecimento =
                      Estabelecimento(_nome.text);
                  _dao
                      .save(newEstabelecimento)
                      .then((value) => Navigator.pop(context));
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ),
      ]),
    );
  }
}
