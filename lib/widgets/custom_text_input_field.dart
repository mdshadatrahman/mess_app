import 'package:flutter/material.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    Key? key,
    required this.label,
    required this.textEditingController,
    this.isObscure = false,
  }) : super(key: key);
  final String label;
  final TextEditingController textEditingController;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: textEditingController,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }
}
