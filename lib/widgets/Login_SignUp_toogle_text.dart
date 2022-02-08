import 'package:flutter/material.dart';

class LoginSignupToogle extends StatelessWidget {
  const LoginSignupToogle(
      {Key? key, required this.text, required this.buttonText, required this.onTap})
      : super(key: key);
  final String text;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: onTap,
            child: Text(
              buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          )
        ],
      ),
    );
  }
}
