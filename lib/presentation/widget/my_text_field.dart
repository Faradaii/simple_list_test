import 'package:flutter/material.dart';
import 'package:simple_list_test/common/constant/constant.dart';

class MyTextField extends StatelessWidget {
  final String textPlaceholder;
  final TextEditingController controller;
  final FormFieldValidator? validator;

  const MyTextField({
    super.key,
    required this.textPlaceholder,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      decoration: InputDecoration(
        hintText: textPlaceholder,
        hintStyle: TextStyle(color: kGray),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kLightGray, width: 1)),
        focusColor: Theme.of(context).colorScheme.onPrimary,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kLightGray, width: 1)),
      ),
      validator: validator,
    );
  }
}
