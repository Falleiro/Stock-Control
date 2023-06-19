import 'package:flutter/material.dart';
import '../../stock/stock.dart';
import '../../stock/stockedit.dart';

class MyLine extends StatefulWidget {
  final String text;
  final int id;
  final Function rebuild;
  final int cep;
  final String estado;
  final String cidade;
  const MyLine({
    super.key,
    required this.text,
    required this.id,
    required this.rebuild,
    required this.cep,
    required this.estado,
    required this.cidade,
  });

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserStock(
                          estabelecimento: widget.text,
                          idEstabelecimento: widget.id),
                    ),
                  );
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
                    builder: (context) => UserStockEdit(
                      estabelecimento: widget.text,
                      idEstabelecimento: widget.id,
                      rebuild: widget.rebuild,
                      cep: widget.cep,
                      estado: widget.estado,
                      cidade: widget.cidade,
                    ),
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
