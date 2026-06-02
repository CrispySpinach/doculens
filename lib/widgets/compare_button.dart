import 'package:flutter/material.dart';

class CompareButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CompareButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          "Compare",
        ),
      ),
    );
  }
}