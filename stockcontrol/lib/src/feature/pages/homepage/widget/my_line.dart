import 'package:flutter/material.dart';
import '../../stock/stock.dart';
import '../../stock/stockedit.dart';

class MyLine extends StatefulWidget {
  final String origem;
  final String text;
  final int id;
  const MyLine(
      {super.key, required this.text, required this.origem, required this.id});

  @override
  State<MyLine> createState() => _MyLineState();
}

class _MyLineState extends State<MyLine> {
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
