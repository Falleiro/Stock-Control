import 'package:flutter/material.dart';
import 'package:stock_control/src/feature/pages/item/item_edit.dart';

class LinhaItem extends StatefulWidget {
  final int idItem;
  final String name;
  final int qtd;
  final int idEstabelecimento;
  final String validade;
  final int lote;
  final Function(int) updateQuantity;
  final Function refresh;
  const LinhaItem(
      {super.key,
      required this.idItem,
      required this.name,
      required this.qtd,
      required this.idEstabelecimento,
      required this.validade,
      required this.lote,
      required this.updateQuantity,
      required this.refresh});

  @override
  State<LinhaItem> createState() => _LinhaItemState();
}

class _LinhaItemState extends State<LinhaItem> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    int qtd = widget.qtd;

    void atualizaQtd(int novaQtd) {
      setState(() {
        qtd = novaQtd;
      });
      widget.updateQuantity(novaQtd);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: TextButton(
                child: Text(
                  name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserItemEdit(
                        name: name,
                        idEstabelecimento: widget.idEstabelecimento,
                        idItem: widget.idItem,
                        qtdItem: widget.qtd,
                        validade: widget.validade,
                        lote: widget.lote,
                        atualizaQtd: atualizaQtd,
                        refresh: widget.refresh,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  '$qtd',
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
