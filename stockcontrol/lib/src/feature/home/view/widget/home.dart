import 'package:flutter/material.dart';
import '../../../../component/Personalizados.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  PreferredSizeWidget _minhabarra(String texto) {
    return MinhaAppBar(
      title: Text(
        texto,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 36,
        ),
      ),
      elevation: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('Home'),
      body: const Center(child: Text('HOME', style: TextStyle(fontSize: 48))),
    );
  }
}
