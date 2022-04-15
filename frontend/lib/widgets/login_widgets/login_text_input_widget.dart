import 'package:flutter/material.dart';

class LoginTextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final double margin;
  const LoginTextInputWidget(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.obscureText,
      required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
