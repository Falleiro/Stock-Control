import 'package:flutter/material.dart';

import '../../../component/personalizados.dart';

class UserStockEdit extends StatelessWidget {
  final String estabelecimento;
  const UserStockEdit({super.key, required this.estabelecimento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra(estabelecimento, context),
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
