import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../component/my_appbar.dart';

class UserLocalization extends StatelessWidget {
  const UserLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinhaAppBar(
        title: Text('appbar-localization'.i18n(),
            style: const TextStyle(color: Colors.white, fontSize: 36)),
        elevation: 10,
      ),
    );
  }
}
