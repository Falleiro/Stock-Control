import 'package:flutter/material.dart';
import '../feature/home/view/page/localization.dart';
import '../feature/home/view/page/stock.dart';
import '../feature/home/view/page/item_edit.dart';
import '../feature/home/view/page/stock_create.dart';
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
  const Linha({super.key, required this.text, required this.origem});

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
                  if (widget.origem == 'estabelecimento') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserStock(estabelecimento: widget.text),
                      ),
                    );
                  } else {}
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
                if (widget.origem == 'estabelecimento') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserStockEdit(estabelecimento: widget.text),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserItemEdit(text: 'arrumar isso dps'),
                    ),
                  );
                }
              },
            )
          ],
        )),
      ),
    );
  }
}

class MeuFloatingActionButton extends StatefulWidget {
  MeuFloatingActionButton({Key? key}) : super(key: key);
  @override
  State<MeuFloatingActionButton> createState() =>
      _MeuFloatingActionButtonState();
}

class _MeuFloatingActionButtonState extends State<MeuFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 24),
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserLocalization()),
              );
            },
            tooltip: 'Vai para a tela de localização',
            child: const Icon(Icons.map),
          ),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserStockCreate(),
              ),
            );
          },
          tooltip: 'Vai para a tela "Cria Estabelecimento" ',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
