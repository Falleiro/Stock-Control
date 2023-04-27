import 'package:flutter/material.dart';

import '../../../../component/Personalizados.dart';

class UserStockCreate extends StatelessWidget {
  const UserStockCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Adicionar estabelecimento', context),
      body: Column(),
    );
  }
}

voltaTela(BuildContext context) => Navigator.pop(context);

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 25)),
    elevation: 10,
  );
}
