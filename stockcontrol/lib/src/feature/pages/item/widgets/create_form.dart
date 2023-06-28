import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool _isDateValid(String date) {
    final RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    if (regex.hasMatch(date)) {
      List<String> components = date.split('/');
      int day = int.parse(components[0]);
      int month = int.parse(components[1]);
      int year = int.parse(components[2]);

      if (day <= 31 && day > 0 && month > 0 && month <= 12 && year >= 2023) {
        return true;
      }
    }

    return false;
  }

  void _showInvalidDateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 245, 66, 66),
          contentTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(220, 0, 0, 0)),
          title: Text("data_invalida".i18n()),
          content: Text("digite_data_valida".i18n()),
        );
      },
    );
    Timer(Duration(seconds: 1, milliseconds: 750), () {
      Navigator.of(context).pop();
    });
  }

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
        TextFormField(
          controller: _validade,
          decoration: InputDecoration(
            labelText: 'validade'.i18n(),
            hintText: "adicionar_validade".i18n(),
            prefixIcon: Icon(Icons.edit, color: Colors.blue),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            labelStyle: const TextStyle(color: Colors.black),
          ),
          style: TextStyle(
            color: Colors.black,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _DateInputFormatter(),
          ],
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
                return "validacao-texto".i18n();
              } else if (int.tryParse(value) == null) {
                return "informe_numero".i18n();
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
                  if (!_isDateValid(_validade.text)) {
                    _showInvalidDateDialog();
                  } else {
                    final String name = _nome.text;
                    const int id = 0;
                    final int idEstabelecimento = widget.idEstabelecimento;
                    final int qtd = int.parse(_adicionar.text);
                    final int lote = int.parse(_lote.text);
                    final String validade = _validade.text;
                    debugPrint(
                        'Esta sendo criado o item $name com o Id do estabelecimento: $idEstabelecimento e foi atribuído o valor de: $qtd, validade: $validade, lote: $lote');
                    final Item newItem =
                        Item(name, idEstabelecimento, id, qtd, lote, validade);
                    _itemDao.save(newItem).then((id) => Navigator.pop(context));
                  }
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

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formattedText = _formatDate(newValue.text);
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatDate(String text) {
    text = text.replaceAll('/', '');
    if (text.length <= 2) {
      return text;
    } else if (text.length <= 4) {
      return '${text.substring(0, 2)}/${text.substring(2)}';
    } else {
      String year = text.substring(4);
      if (year.length > 4) {
        year = year.substring(0, 4);
      }
      return '${text.substring(0, 2)}/${text.substring(2, 4)}/$year';
    }
  }
}
