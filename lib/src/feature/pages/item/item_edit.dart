import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/item/widgets/delete_button.dart';
import 'package:stock_control/src/component/row_form.dart';
import 'package:stock_control/src/feature/pages/item/widgets/submit_button.dart';
import 'package:stock_control/src/feature/repository/dao/itens_dao.dart';

import '../../../component/my_appbar.dart';

class UserItemEdit extends StatefulWidget {
  final String name;
  final int idEstabelecimento;
  final int idItem;
  final int qtdItem;
  final String validade;
  final int lote;
  final Function(int) atualizaQtd;
  final Function refresh;
  const UserItemEdit({
    super.key,
    required this.name,
    required this.idEstabelecimento,
    required this.idItem,
    required this.qtdItem,
    required this.validade,
    required this.lote,
    required this.atualizaQtd,
    required this.refresh,
  });

  @override
  State<UserItemEdit> createState() => _UserItemEditState();
}

class _UserItemEditState extends State<UserItemEdit> {
  final _addFormKey = GlobalKey<FormState>();
  final _removeFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();
  final _loteFormKey = GlobalKey<FormState>();
  final _validadeFormKey = GlobalKey<FormState>();
  final _add = TextEditingController();
  final _remove = TextEditingController();
  final _nome = TextEditingController();
  final _validade = TextEditingController();
  final _lote = TextEditingController();
  final ItemDao _dao = ItemDao();

  addItem() {
    if (_addFormKey.currentState!.validate()) {
      widget.atualizaQtd(widget.qtdItem + int.parse(_add.text));
      _dao
          .updateQuantity(
              widget.idItem, (widget.qtdItem + int.parse(_add.text)))
          .then((id) => Navigator.pop(context));
    }
  }

  removeItem() {
    if (_removeFormKey.currentState!.validate()) {
      widget.atualizaQtd(widget.qtdItem - int.parse(_remove.text));
      _dao
          .updateQuantity(
              widget.idItem, (widget.qtdItem - int.parse(_remove.text)))
          .then((id) => Navigator.pop(context));
    }
  }

  atualizaNome() {
    if (_nameFormKey.currentState!.validate()) {
      widget.refresh();
      _dao
          .updateName(widget.idItem, _nome.text)
          .then((id) => Navigator.pop(context));
    }
  }

  atualizaLote() {
    debugPrint('Chamando a função');
    widget.refresh();
    if (_loteFormKey.currentState!.validate()) {
      _dao
          .updateLote(widget.idItem, int.parse(_lote.text))
          .then((id) => Navigator.pop(context));
    }
  }

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
    Timer(Duration(seconds: 1, milliseconds: 100), () {
      Navigator.of(context).pop();
    });
  }

  atualizaValidade() {
    widget.refresh();
    if (_validadeFormKey.currentState!.validate()) {
      if (!_isDateValid(_validade.text)) {
        _showInvalidDateDialog();
      } else {
        _dao
            .updateValidade(widget.idItem, _validade.text)
            .then((id) => Navigator.pop(context));
      }
    }
  }

  deletaItem() {
    widget.refresh();
    _dao.delete(widget.idItem).then((id) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    _dao.findAllByEstabelecimento(widget.idEstabelecimento);
    return Scaffold(
      appBar: MinhaAppBar(
        title: Text(widget.name,
            style: const TextStyle(color: Colors.white, fontSize: 36)),
        elevation: 10,
      ),
      body: ListView(
        children: [
          Center(
            child: Text(
              '${"quantidade_de".i18n()} ${widget.name}: ${widget.qtdItem}',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          MyRowForm(
            formKey: _addFormKey,
            myController: _add,
            fieldName: 'add-item'.i18n(),
            isNumber: true,
            operation: addItem,
          ),
          MyRowForm(
            formKey: _removeFormKey,
            myController: _remove,
            fieldName: 'remove-item'.i18n(),
            isNumber: true,
            operation: removeItem,
          ),
          MyRowForm(
            formKey: _nameFormKey,
            myController: _nome,
            fieldName: "nome_item".i18n(),
            isNumber: false,
            operation: atualizaNome,
          ),
          MyRowForm(
            formKey: _loteFormKey,
            myController: _lote,
            fieldName: '${"lote".i18n()}: ${widget.lote}',
            isNumber: false,
            operation: atualizaLote,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _validadeFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _validade,
                      decoration: InputDecoration(
                        labelText: '${"validade:".i18n()}${widget.validade}',
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
                  ),
                  MySubmitButton(operation: atualizaValidade),
                ],
              ),
            ),
          ),
          // MyRowForm(
          //   formKey: _validadeFormKey,
          //   myController: _validade,
          //   fieldName: '${"validade".i18n()}: ${widget.validade}',
          //   isNumber: false,
          //   operation: atualizaValidade,
          // ),
          DeleteButton(
            nome: widget.name,
            delete: deletaItem,
          ),
        ],
      ),
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
