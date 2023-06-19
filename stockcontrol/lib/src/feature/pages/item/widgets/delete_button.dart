import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DeleteButton extends StatelessWidget {
  final String nomeItem;
  final Function deletaItem;
  const DeleteButton(
      {super.key, required this.nomeItem, required this.deletaItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 140),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("deseja_remover".i18n() + ' $nomeItem?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("nao".i18n()),
                ),
                TextButton(
                  onPressed: () {
                    deletaItem();
                    Navigator.pop(context);
                  },
                  child: Text("sim".i18n()),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text("deletar_item".i18n()),
      ),
    );
  }
}
