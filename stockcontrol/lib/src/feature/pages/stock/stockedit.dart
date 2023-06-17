import 'package:flutter/material.dart';

import '../../../component/my_appbar.dart';

class UserStockEdit extends StatelessWidget {
  final String estabelecimento;
  const UserStockEdit({super.key, required this.estabelecimento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinhaAppBar(
        title: Text(estabelecimento,
            style: const TextStyle(color: Colors.white, fontSize: 36)),
        elevation: 10,
      ),
    );
  }
}
