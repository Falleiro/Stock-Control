import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:stock_control/src/feature/pages/item/widgets/create_form.dart';

import '../../../component/my_appbar.dart';

class UserItemCreate extends StatefulWidget {
  final int idEstabelecimento;
  const UserItemCreate({super.key, required this.idEstabelecimento});

  @override
  State<UserItemCreate> createState() => _UserItemCreateState();
}

class _UserItemCreateState extends State<UserItemCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinhaAppBar(
        title: Text('appbar-cria-item'.i18n(),
            style: const TextStyle(color: Colors.white, fontSize: 36)),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyItemForm(
              idEstabelecimento: widget.idEstabelecimento,
            )
          ],
        ),
      ),
    );
  }
}
