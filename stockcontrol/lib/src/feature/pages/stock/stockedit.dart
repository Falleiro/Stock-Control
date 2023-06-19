import 'package:flutter/material.dart';
import 'package:stock_control/src/component/row_form.dart';
import 'package:stock_control/src/feature/pages/item/widgets/delete_button.dart';
import 'package:stock_control/src/feature/repository/dao/estabelecimento_dao.dart';

import '../../../component/my_appbar.dart';

class UserStockEdit extends StatefulWidget {
  final String estabelecimento;
  final int idEstabelecimento;
  final Function rebuild;
  final int cep;
  final String estado;
  final String cidade;
  const UserStockEdit({
    super.key,
    required this.estabelecimento,
    required this.idEstabelecimento,
    required this.rebuild,
    required this.cep,
    required this.estado,
    required this.cidade,
  });

  @override
  State<UserStockEdit> createState() => _UserStockEditState();
}

class _UserStockEditState extends State<UserStockEdit> {
  final _nameFormKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _cepFormKey = GlobalKey<FormState>();
  final _cep = TextEditingController();
  final _ufFormKey = GlobalKey<FormState>();
  final _uf = TextEditingController();
  final _cidadeFormKey = GlobalKey<FormState>();
  final _cidade = TextEditingController();
  final EstabelecimentoDao _dao = EstabelecimentoDao();

  atualizaNome() {
    if (_nameFormKey.currentState!.validate()) {
      widget.rebuild();
      _dao
          .updateName(widget.idEstabelecimento, _name.text)
          .then((id) => Navigator.pop(context));
    }
  }

  atualizaCep() {
    if (_cepFormKey.currentState!.validate()) {
      widget.rebuild();
      _dao
          .updateCep(widget.idEstabelecimento, int.parse(_cep.text))
          .then((id) => Navigator.pop(context));
    }
  }

  atualizaEstado() {
    if (_ufFormKey.currentState!.validate()) {
      widget.rebuild();
      _dao
          .updateEstado(widget.idEstabelecimento, _uf.text)
          .then((id) => Navigator.pop(context));
    }
  }

  atualizaCidade() {
    if (_cidadeFormKey.currentState!.validate()) {
      widget.rebuild();
      _dao
          .updateCidade(widget.idEstabelecimento, _cidade.text)
          .then((id) => Navigator.pop(context));
    }
  }

  deletaEstabelecimento() {
    widget.rebuild();
    _dao.delete(widget.idEstabelecimento).then((id) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinhaAppBar(
        title: Text(widget.estabelecimento,
            style: const TextStyle(color: Colors.white, fontSize: 36)),
        elevation: 10,
      ),
      body: ListView(
        children: [
          MyRowForm(
            formKey: _nameFormKey,
            myController: _name,
            fieldName: 'Nome do Estoque',
            isNumber: false,
            operation: atualizaNome,
          ),
          MyRowForm(
            formKey: _cepFormKey,
            myController: _cep,
            fieldName: 'Cep: ${widget.cep}',
            isNumber: true,
            operation: atualizaCep,
          ),
          MyRowForm(
            formKey: _ufFormKey,
            myController: _uf,
            fieldName: 'Estado: ${widget.estado}',
            isNumber: false,
            operation: atualizaEstado,
          ),
          MyRowForm(
            formKey: _cidadeFormKey,
            myController: _cidade,
            fieldName: 'Cidade: ${widget.cidade}',
            isNumber: false,
            operation: atualizaCidade,
          ),
          DeleteButton(
            nome: widget.estabelecimento,
            delete: deletaEstabelecimento,
          ),
        ],
      ),
    );
  }
}
