import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({Key? key, required this.hint, required this.icon}) : super(key: key);

  String hint;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Color(0xFFF6F7F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        prefixIcon: icon,
        hintText: hint,
      ),
    );
  }
}
