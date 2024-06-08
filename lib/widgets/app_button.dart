import 'package:flutter/material.dart';
import '../app_constant.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPress
  });

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: appLineColor,
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)), // Square corners
          ),
          minimumSize: const Size(175, 48), // Custom size: width 150, height 50
        ),
        child: Text(
          'Next',
          style: btnTxt,
        ),
      ),
    );
  }
}