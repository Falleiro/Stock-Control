import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/item/widgets/create_form.dart';

import '../../../component/personalizados.dart';

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

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 36)),
    elevation: 10,
  );
}
