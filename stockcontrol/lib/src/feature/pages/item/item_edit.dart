import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/item/widgets/edit_form.dart';
import 'package:stock_control/src/feature/repository/dao/itens_dao.dart';

import '../../../component/personalizados.dart';

class UserItemEdit extends StatefulWidget {
  final String text;
  final int idEstabelecimento;
  final int idItem;
  final int qtdItem;
  final String validade;
  final int lote;
  final void Function(int) atualizaQtd;
  const UserItemEdit({
    super.key,
    required this.text,
    required this.idEstabelecimento,
    required this.idItem,
    required this.qtdItem,
    required this.atualizaQtd,
    required this.validade,
    required this.lote,
  });

  @override
  State<UserItemEdit> createState() => _UserItemEditState();
}

class _UserItemEditState extends State<UserItemEdit> {
  final _addFormKey = GlobalKey<FormState>();
  final _removeFormKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    _dao.findAllByEstabelecimento(widget.idEstabelecimento);
    return Scaffold(
      appBar: _minhabarra(widget.text, context),
      body: Column(
        children: [
          Text(
            'Quantidade do item ${widget.text}: ${widget.qtdItem}',
            style: const TextStyle(fontSize: 15),
          ),
          //FORM PARA O ADD
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _addFormKey,
                    child: MyTextForm(
                      myController: _add,
                      fieldName: 'add-item'.i18n(),
                      hintText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        addItem();
                      },
                      child: Text('submit'.i18n()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //FORM PARA O REMOVE
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _removeFormKey,
                    child: MyTextForm(
                      myController: _remove,
                      fieldName: 'remove-item'.i18n(),
                      hintText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        removeItem();
                      },
                      child: Text('submit'.i18n()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
            child: Column(
              children: [
                MyTextForm(
                  myController: _nome,
                  fieldName: 'Nome do item',
                  hintText: widget.text,
                ),
                MyTextForm(
                  myController: _lote,
                  fieldName: 'Lote do item',
                  hintText: widget.text,
                ),
                MyTextForm(
                  myController: _validade,
                  fieldName: 'Validade do item',
                  hintText: widget.text,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 36)),
    elevation: 10,
  );
}
