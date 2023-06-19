import 'package:flutter/material.dart';

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
              title: Text(' Deseja realmente remover $nome'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    delete();
                    Navigator.pop(context);
                  },
                  child: const Text('Sim'),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text('Deletar $nome'),
      ),
    );
  }
}
