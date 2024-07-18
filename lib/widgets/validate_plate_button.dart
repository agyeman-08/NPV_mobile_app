import 'package:flutter/material.dart';

class ValidatePlateButton extends StatelessWidget {
  final void Function()? onPressed;
  const ValidatePlateButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          foregroundColor: const WidgetStatePropertyAll(Colors.black),
          backgroundColor: WidgetStatePropertyAll(Colors.red.shade200)),
      child: const Text('Validate'),
    );
  }
}
