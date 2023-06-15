import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/localization/localization.dart';
import 'package:stock_control/src/feature/pages/stock/stock_create.dart';

class ButtonRow extends StatelessWidget {
  final Function atualizarLista;
  const ButtonRow({super.key, required this.atualizarLista});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 24),
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserLocalization()),
              );
            },
            tooltip: 'tooltip-localization'.i18n(),
            child: const Icon(Icons.map),
          ),
        ),
        FloatingActionButton(
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
        ),
      ],
    );
  }
}
