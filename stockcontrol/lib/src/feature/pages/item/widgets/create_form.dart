import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/component/my_text_field.dart';
import 'package:stock_control/src/feature/repository/dao/itens_dao.dart';
import 'package:stock_control/src/feature/viewmodel/itens_viewmodel.dart';

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
  final _adicionar = TextEditingController();

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
        //Fazendo um TextFormFiel específico para o campo de adicionar item.
        //Os outros estão sendo padronizados no /component/my_text_field.dart
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TextFormField(
            controller: _adicionar,
            decoration: InputDecoration(
              labelText: 'add-item'.i18n(),
              prefixIcon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              labelStyle: const TextStyle(color: Colors.black),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Esse campo precisa ser preenchido';
              } else if (int.tryParse(value) == null) {
                return 'Informe um NÚMERO';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String name = _nome.text;
                  const int id = 0;
                  final int idEstabelecimento = widget.idEstabelecimento;
                  final int qtd = int.parse(_adicionar.text);
                  debugPrint(
                      'Esta sendo criado um item com o Id do estabelecimento: $idEstabelecimento e foi atribuído o valor de: $qtd');
                  final Item newItem = Item(name, idEstabelecimento, id, qtd);
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
