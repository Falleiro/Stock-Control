import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/item/widgets/delete_button.dart';
import 'package:stock_control/src/component/row_form.dart';
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

  atualizaValidade() {
    widget.refresh();
    if (_validadeFormKey.currentState!.validate()) {
      _dao
          .updateValidade(widget.idItem, _validade.text)
          .then((id) => Navigator.pop(context));
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
              'Quantidade de ${widget.name}: ${widget.qtdItem}',
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
            fieldName: 'Nome do item',
            isNumber: false,
            operation: atualizaNome,
          ),
          MyRowForm(
            formKey: _loteFormKey,
            myController: _lote,
            fieldName: 'Lote: ${widget.lote}',
            isNumber: false,
            operation: atualizaLote,
          ),
          MyRowForm(
            formKey: _validadeFormKey,
            myController: _validade,
            fieldName: 'Validade: ${widget.validade}',
            isNumber: false,
            operation: atualizaValidade,
          ),
          DeleteButton(
            nome: widget.name,
            delete: deletaItem,
          ),
        ],
      ),
    );
  }
}
