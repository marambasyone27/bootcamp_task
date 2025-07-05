import 'package:flutter/material.dart';

class custom_button extends StatelessWidget {
  const custom_button({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onPressed,
    required this.text, this.controller,
  });
    final TextEditingController? controller;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
