import 'package:flutter/material.dart';

import '../../../../component/Personalizados.dart';

class UserStock extends StatelessWidget {
  const UserStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Itens - Estabelecimento 1', context),
    );
  }
}

voltaTela(BuildContext context) => Navigator.pop(context);

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 26)),
    elevation: 10,
  );
}
