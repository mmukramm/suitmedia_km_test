import 'package:flutter/material.dart';
import 'package:suitmedia_km_test/styles/colors.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController textEditingController;
  const CustomInput({
    super.key,
    this.hintText = '',
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: scaffoldColor,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
