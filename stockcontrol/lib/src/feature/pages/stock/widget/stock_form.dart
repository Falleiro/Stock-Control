import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/component/my_text_field.dart';
import 'package:stock_control/src/feature/repository/dao/estabelecimento_dao.dart';
import 'package:stock_control/src/feature/viewmodel/estabelecimento_viewmodel.dart';

class MyStockForm extends StatefulWidget {
  final Function atualizarLista;
  const MyStockForm({super.key, required this.atualizarLista});

  @override
  State<MyStockForm> createState() => _MyStockFormState();
}

class _MyStockFormState extends State<MyStockForm> {
  final EstabelecimentoDao _dao = EstabelecimentoDao();

  final _formKey = GlobalKey<FormState>();

  final _nome = TextEditingController();

  final _cep = TextEditingController();

  final _uf = TextEditingController();

  final _cidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        MyTextField(
          myController: _nome,
          fieldName: 'nome-estabelecimento'.i18n(),
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _cep,
          fieldName: 'cep'.i18n(),
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _uf,
          fieldName: 'uf'.i18n(),
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _cidade,
          fieldName: 'cidade'.i18n(),
          myIcon: Icons.home,
          prefixIconColor: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String name = _nome.text;
                  const int id = 0;
                  final Estabelecimento newEstabelecimento =
                      Estabelecimento(name, id);
                  _dao.save(newEstabelecimento).then((id) {
                    widget.atualizarLista();
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text('submit'.i18n()),
            ),
          ),
        ),
      ]),
    );
  }
}
