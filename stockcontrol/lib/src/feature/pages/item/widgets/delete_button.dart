import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DeleteButton extends StatelessWidget {
  final String nome;
  final Function delete;
  const DeleteButton({super.key, required this.nome, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 140),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("deseja_remover".i18n() + ' $nome?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("nao".i18n()),
                ),
                TextButton(
                  onPressed: () {
                    delete();
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
