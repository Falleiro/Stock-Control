import 'package:flutter/material.dart';

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
              title: Text(' Deseja realmente remover $nomeItem'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    deletaItem();
                    Navigator.pop(context);
                  },
                  child: const Text('Sim'),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text('Deletar item'),
      ),
    );
  }
}
