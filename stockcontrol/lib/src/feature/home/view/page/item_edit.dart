import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../component/personalizados.dart';

class UserItemEdit extends StatefulWidget {
  final String text;
  const UserItemEdit({super.key, required this.text});

  @override
  State<UserItemEdit> createState() => _UserItemEditState();
}

class _UserItemEditState extends State<UserItemEdit> {
  final _addFormKey = GlobalKey<FormState>();
  final _removeFormKey = GlobalKey<FormState>();
  final _add = TextEditingController();
  final _remove = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minhabarra('${widget.text}', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _addFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextForm(
                            myController: _add,
                            fieldName: 'add-item'.i18n(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_addFormKey.currentState!.validate()) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text('submit'.i18n()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _removeFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextForm(
                            myController: _remove,
                            fieldName: 'Quantidade de item que deseja remover',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_removeFormKey.currentState!.validate()) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text('submit'.i18n()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

voltaTela(BuildContext context) => Navigator.pop(context);

PreferredSizeWidget _minhabarra(String texto, context) {
  return MinhaAppBar(
    title:
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 36)),
    elevation: 10,
  );
}

class MyTextForm extends StatefulWidget {
  final TextEditingController myController;
  final String fieldName;
  const MyTextForm(
      {super.key, required this.myController, required this.fieldName});

  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

class _MyTextFormState extends State<MyTextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: widget.myController,
        decoration: InputDecoration(
            labelText: widget.fieldName,
            prefixIcon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            labelStyle: const TextStyle(color: Colors.black)),
        validator: (value) {
          if (value != null && int.tryParse(value) == null) {
            return 'Informe um NÚMERO';
          }
          return null;
        },
      ),
    );
  }
}
