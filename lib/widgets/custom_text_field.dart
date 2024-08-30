import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final bool isPass;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final Color borderColor; // Added this line
  final Color hintTextColor; // Added this line
  final Color iconColor; // Added this line
  final Color fillColor; // Added this line

  const CustomTextField({
    super.key,
    required this.icon,
    this.isPass = false,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.validator,
    this.borderColor = Colors.grey, // Default border color
    this.hintTextColor = Colors.black, // Default hint text color
    this.iconColor = Colors.black, // Default icon color
    this.fillColor = Colors.grey, // Default fill color
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon.icon,
          color: widget.iconColor, // Updated this line
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintTextColor), // Updated this line
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.borderColor), // Updated this line
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
                icon: Icon(
                  isHidden
                      ? Icons.visibility_sharp
                      : Icons.visibility_off_sharp,
                  color: widget.iconColor, // Updated this line
                ),
              )
            : Container(
                width: 0,
              ),
        fillColor: widget.fillColor, // Updated this line
        errorText: widget.errorText,
      ),
      obscureText: widget.isPass ? isHidden : false,
      validator: widget.validator,
    );
  }
}
