import 'package:flutter/material.dart';
import 'package:newsly/utils/keyboard_type.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.placeholder,
    this.prefixIcon,
    this.isObscure,
    this.controller,
    this.errorText,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.type = KeyboardType.text
  });

  final String placeholder;
  final IconData? prefixIcon;
  final bool? isObscure;
  final TextEditingController? controller;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final KeyboardType? type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: isObscure ?? false,
      validator: validator,
      keyboardType: getKeyboardType(type!),
      onSaved: onSaved,
      decoration: InputDecoration(
        errorText: errorText != "" ? errorText : null,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        hintText: placeholder,
      ),
    );
  }
}

TextInputType getKeyboardType(KeyboardType type) {
  switch (type) {
    case KeyboardType.email:
      return TextInputType.emailAddress;
    case KeyboardType.password:
      return TextInputType.visiblePassword;
    case KeyboardType.text:
      return TextInputType.text;
  }
}