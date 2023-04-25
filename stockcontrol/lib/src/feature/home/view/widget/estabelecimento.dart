import 'package:flutter/material.dart';

import '../../../../component/Personalizados.dart';

class UserEstabelecimento extends StatelessWidget {
  const UserEstabelecimento({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Estabelecimento 1', context),
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
