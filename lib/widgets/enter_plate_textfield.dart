import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnterPlateTextField extends StatelessWidget {
  final TextEditingController controller;

  const EnterPlateTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        decoration: const InputDecoration(
          hintText: "AR 0000-24",
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
