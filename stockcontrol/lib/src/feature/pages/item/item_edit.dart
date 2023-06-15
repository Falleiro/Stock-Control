import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/item/widgets/edit_form.dart';
import 'package:stock_control/src/feature/repository/dao/itens_dao.dart';

import '../../../component/personalizados.dart';

class UserItemEdit extends StatefulWidget {
  final String name;
  final int idEstabelecimento;
  final int idItem;
  final int qtdItem;
  final String validade;
  final int lote;
  final Function(int) atualizaQtd;
  final Function(String) atualizaNome;
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
    required this.atualizaNome,
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
      widget.atualizaNome(_nome.text.toString());
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

  @override
  Widget build(BuildContext context) {
    _dao.findAllByEstabelecimento(widget.idEstabelecimento);
    return Scaffold(
      appBar: _minhabarra(widget.name, context),
      body: ListView(
        children: [
          Center(
            child: Text(
              'Quantidade de ${widget.name}: ${widget.qtdItem}',
              style: const TextStyle(fontSize: 15),
            ),
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
                      isAddOrRemove: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.center,
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
                      isAddOrRemove: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.center,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _nameFormKey,
                    child: MyTextForm(
                      myController: _nome,
                      fieldName: 'Nome do item',
                      hintText: widget.name,
                      isAddOrRemove: false,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('ATUALIANDO O NOME!!');
                        atualizaNome();
                      },
                      child: Text('submit'.i18n()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _loteFormKey,
                    child: MyTextForm(
                      myController: _lote,
                      fieldName: 'Lote: ${widget.lote}',
                      hintText: '',
                      isAddOrRemove: false,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('Antes de chamar a função');
                        atualizaLote();
                      },
                      child: Text('submit'.i18n()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _validadeFormKey,
                    child: MyTextForm(
                      myController: _validade,
                      fieldName: 'Validade: ${widget.validade}',
                      hintText: '',
                      isAddOrRemove: false,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        atualizaValidade();
                      },
                      child: Text('submit'.i18n()),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
