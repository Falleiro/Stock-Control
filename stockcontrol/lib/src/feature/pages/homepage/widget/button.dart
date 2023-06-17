import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/stock/stock_create.dart';

class Button extends StatelessWidget {
  final Function atualizarLista;
  const Button({
    super.key,
    required this.atualizarLista,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UserStockCreate(atualizarLista: atualizarLista),
          ),
        );
      },
      tooltip: 'tooltip-estabelecimento'.i18n(),
      child: const Icon(Icons.add),
    );
  }
}
