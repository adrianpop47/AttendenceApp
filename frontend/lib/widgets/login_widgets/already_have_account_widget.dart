import 'package:flutter/material.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account ?"),
        TextButton(
            onPressed: () {
              _openLoginScreen(context);
            },
            child: const Text("Login")),
      ],
    );
  }

  void _openLoginScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
