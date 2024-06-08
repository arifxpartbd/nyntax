
import 'package:flutter/material.dart';
import 'package:nyntax/app_constant.dart';

class AppDropdownField extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.items,
    this.onChanged,
    this.value,
  });

  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: const InputDecoration(
          border:  OutlineInputBorder(
            borderSide: BorderSide(color: appFieldColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appFieldColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appFieldColor),
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down, color: appIconColor),
      ),
    );
  }
}
