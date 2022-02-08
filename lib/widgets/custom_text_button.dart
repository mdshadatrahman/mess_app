import 'package:flutter/material.dart';
import 'package:mess_app/Utilities/constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        onPressed: onPressed,
        child: Text(buttonText),
        style: TextButton.styleFrom(
          backgroundColor: Constants().primaryColor,
          primary: Colors.white,
        ),
      ),
    );
  }
}
