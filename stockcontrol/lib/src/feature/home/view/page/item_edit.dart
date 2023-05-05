import 'package:flutter/material.dart';

import '../../../../component/personalizados.dart';

class UserItemEdit extends StatefulWidget {
  final String text;
  const UserItemEdit({super.key, required this.text});

  @override
  State<UserItemEdit> createState() => _UserItemEditState();
}

class _UserItemEditState extends State<UserItemEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('${widget.text}', context),
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
