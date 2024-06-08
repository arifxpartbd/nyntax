import 'package:flutter/material.dart';
import 'package:nyntax/app_constant.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    this.controller,
    this.iconData,
    this.onPress,
    this.onlyRead = false,
    this.onChanged,
    this.validator,
    this.hintText
  });

  final TextEditingController? controller;
  final IconData? iconData;
  final VoidCallback? onPress;
  final bool onlyRead;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        readOnly: onlyRead,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: iconData != null
              ? IconButton(
            icon: Icon(iconData, color: appIconColor),
            onPressed: onPress,
          )
              : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: appFieldColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: appFieldColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: appFieldColor),
          ),
        ),
      ),
    );
  }
}
