import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../component/personalizados.dart';
import '../../../../component/my_text_field.dart';
import '../../repository/dao/itens_dao.dart';
import '../../viewmodel/itens_viewmodel.dart';

class UserItemCreate extends StatefulWidget {
  final int idEstabelecimento;
  const UserItemCreate({super.key, required this.idEstabelecimento});

  @override
  State<UserItemCreate> createState() => _UserItemCreateState();
}

class _UserItemCreateState extends State<UserItemCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('appbar-cria-item'.i18n(), context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyItemForm(
              idEstabelecimento: widget.idEstabelecimento,
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
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 36)),
    elevation: 10,
  );
}

class MyItemForm extends StatefulWidget {
  final int idEstabelecimento;
  const MyItemForm({super.key, required this.idEstabelecimento});

  @override
  State<MyItemForm> createState() => _MyItemFormState();
}

class _MyItemFormState extends State<MyItemForm> {
  final ItemDao _itemDao = ItemDao();
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
          fieldName: 'nome-item'.i18n(),
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _lote,
          fieldName: 'lote'.i18n(),
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _validade,
          fieldName: 'validade'.i18n(),
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        MyTextField(
          myController: _adicioanar,
          fieldName: 'add-item'.i18n(),
          myIcon: Icons.edit,
          prefixIconColor: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String name = _nome.text;
                  const int id = 0;
                  final int idEstabelecimento = widget.idEstabelecimento;
                  debugPrint(
                      'Esta sendo criado um item com o Id do estabelecimento: $idEstabelecimento');
                  final Item newItem = Item(name, idEstabelecimento, id);
                  _itemDao.save(newItem).then((id) => Navigator.pop(context));
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
