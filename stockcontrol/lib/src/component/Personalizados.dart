import 'package:flutter/material.dart';
import '../feature/home/view/page/stock.dart';
import '../feature/home/view/page/stockedit.dart';

class MinhaAppBar extends AppBar {
  MinhaAppBar({
    super.key,
    super.backgroundColor = Colors.blue,
    super.title = const Text('Home'),
    super.elevation,
    super.actions,
    super.automaticallyImplyLeading,
  });
}

class Linha extends StatefulWidget {
  final String origem;
  final String text;
  //esse id pode ser tanto do estabelecimento quanto do item, depende do que é a linha
  final int id;
  const Linha(
      {super.key, required this.text, required this.origem, required this.id});

  @override
  State<Linha> createState() => _LinhaState();
}

//LINHA QUE VAI SERVIR PARA ESTABELECIMENTO
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
                  if (widget.origem == 'estabelecimento') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserStock(
                            estabelecimento: widget.text,
                            idEstabelecimento: widget.id),
                      ),
                    );
                  } else {}
                },
                child: Text(
                  widget.text,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserStockEdit(estabelecimento: widget.text),
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
