import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/stock/widget/stock_form.dart';
import '../../../component/personalizados.dart';

class UserStockCreate extends StatefulWidget {
  final Function atualizarLista;
  const UserStockCreate({super.key, required this.atualizarLista});

  @override
  State<UserStockCreate> createState() => _UserStockCreateState();
}

class _UserStockCreateState extends State<UserStockCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('appbar-add-estabelecimento'.i18n(), context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyStockForm(atualizarLista: widget.atualizarLista),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 25)),
    elevation: 10,
  );
}
