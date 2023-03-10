import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({Key? key,
    this.hint,
    this.icon,
    this.controller,
    this.validator,
    this.inputType,
    this.suffixIcon,
    this.action,
    this.focusNode,
    this.obscureText = false,
    this.maxLines,
    this.maxLength,
  }) : super(key: key);

  TextEditingController? controller;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  TextInputType? inputType;
  TextInputAction? action;
  String? hint;
  Icon? icon;
  FocusNode? focusNode;
  bool obscureText = false;
  int? maxLines;
  int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: action,
      onEditingComplete: () => FocusScope.of(context).requestFocus(focusNode),
      keyboardType: inputType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: icon,
        hintText: hint,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(50),
        )
      ),
    );
  }
}
