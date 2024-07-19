import 'package:flutter/material.dart';

class EnterPlateTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const EnterPlateTextField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        focusNode: focusNode,
        decoration: const InputDecoration(
          hintText: "AR-0000-24",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
