import 'package:flutter/material.dart';

class CustomCheckboxListItem extends StatelessWidget {
  final String text;
  final String price;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxListItem({
    super.key,
    required this.text,
    required this.price,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Text(text),
          ],
        ),
        Text(price),
      ],
    );
  }
}
