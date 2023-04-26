import 'package:flutter/material.dart';
import 'package:stock_control/src/feature/home/view/widget/stock.dart';
import '../feature/home/view/widget/stockedit.dart';

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
  final String text;
  const Linha({super.key, required this.text});

  @override
  State<Linha> createState() => _LinhaState();
}

//LINHA QUE VAI SERVIR PARA ESTABELECIMENTO E ITEM
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
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserStock(),
                    ),
                  );
                },
                child: Text(
                  widget.text,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserStockEdit(),
                  ),
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
