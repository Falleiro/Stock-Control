import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class MySubmitButton extends StatefulWidget {
  final Function operation;
  const MySubmitButton({
    super.key,
    required this.operation,
  });

  @override
  State<MySubmitButton> createState() => _MySubmitButtonState();
}

class _MySubmitButtonState extends State<MySubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            widget.operation();
          },
          child: Text('submit'.i18n()),
        ),
      ),
    );
  }
}
