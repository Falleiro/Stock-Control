import 'package:flutter/material.dart';

class MinhaAppBar extends AppBar {
  MinhaAppBar({
    super.key,
    super.backgroundColor = Colors.blue,
    super.title = const Text('Home'),
    super.elevation,
    super.actions,
  });
}

class Linha extends StatefulWidget {
  const Linha({super.key});

  @override
  State<Linha> createState() => _LinhaState();
}

class _LinhaState extends State<Linha> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        height: 50,
        child: (Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 70),
              child: const Text('Estabelecimento 1',
                  style: TextStyle(color: Colors.white, fontSize: 26)),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            )
          ],
        )),
      ),
    );
  }
}
