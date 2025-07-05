import 'package:flutter/material.dart';

class custom_textFormField extends StatelessWidget {
  const custom_textFormField({
    super.key,
    required this.controller,
    required this.screenSize,
    required this.hintText,
    required this.validator,
    required this.label,
  });
  final TextEditingController? controller;
  final Size screenSize;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon:
              const Icon(Icons.email_outlined, color: Colors.pinkAccent),
          contentPadding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.025,
            horizontal: screenSize.width * 0.05,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFFF5A9C2)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 236, 144, 175)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.pink),
          ),
          label: Text(label!),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        validator: validator);
  }
}
