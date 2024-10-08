import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final bool isPass;
  final String? errorText; // Add this line
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.icon,
    this.isPass = false,
    required this.controller,
    required this.hintText,
    this.errorText, // Add this line
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Change from TextField to TextFormField
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: isHidden
                    ? const Icon(Icons.visibility_sharp)
                    : const Icon(Icons.visibility_off_sharp))
            : Container(
                width: 0,
              ),
        fillColor: Colors.grey[200],
        errorText: widget.errorText, // Add this line
      ),
      obscureText: widget.isPass ? isHidden : false,
      validator: widget.validator, // Add this line
    );
  }
}
