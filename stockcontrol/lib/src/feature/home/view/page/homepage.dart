import 'package:flutter/material.dart';

import '../widget/home.dart';
import '../widget/config.dart';
import '../../../../component/Minha_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Stock Control', context),
    );
  }
}

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.black, fontSize: 36)),
    elevation: 10,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserConfig()));
        },
      )
    ],
  );
}
