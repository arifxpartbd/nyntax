import 'package:flutter/material.dart';
import '../app_constant.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key, required this.child,
  });
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: appFieldColor),
      ),
      child:  Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 8.0),
        child: child,
      ),
    );
  }
}
