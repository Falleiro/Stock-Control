import 'package:flutter/material.dart';
import 'package:stock_control/src/feature/pages/item/widgets/edit_form.dart';
import 'package:stock_control/src/feature/pages/item/widgets/submit_button.dart';

class MyRowForm extends StatelessWidget {
  final Key? formKey;
  final TextEditingController myController;
  final String fieldName;
  final String hintText;
  final bool isAddOrRemove;
  final Function operation;

  const MyRowForm({
    super.key,
    this.formKey,
    required this.myController,
    required this.fieldName,
    required this.hintText,
    required this.isAddOrRemove,
    required this.operation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Row(
          children: [
            Expanded(
              child: MyTextForm(
                myController: myController,
                fieldName: fieldName,
                hintText: hintText,
                isAddOrRemove: isAddOrRemove,
              ),
            ),
            MySubmitButton(
              operation: operation,
            )
          ],
        ),
      ),
    );
  }
}
