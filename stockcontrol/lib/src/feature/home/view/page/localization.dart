import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../component/Personalizados.dart';

class UserLocalization extends StatelessWidget {
  const UserLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('appbar-localization'.i18n(), context),
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
