import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ValidatePlateButton extends StatefulWidget {
  final TextEditingController controller;

  const ValidatePlateButton({
    super.key,
    required this.controller,
    required onpressed,
  });

  @override
  _ValidatePlateButtonState createState() => _ValidatePlateButtonState();
}

class _ValidatePlateButtonState extends State<ValidatePlateButton> {
  String? _address;
  String? _contact;
  String? _errorMessage;

  Future<void> _validateAndFetch() async {
    String input = widget.controller.text;

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Number Plate')
          .doc(input)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          _address = documentSnapshot.get('Address');
          _contact = documentSnapshot.get('Contact');
          _errorMessage = null;
        });
      } else {
        setState(() {
          _address = null;
          _contact = null;
          _errorMessage = 'Document ID not found';
        });
      }
    } catch (e) {
      setState(() {
        _address = null;
        _contact = null;
        _errorMessage = 'Error fetching data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _validateAndFetch,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        backgroundColor: MaterialStateProperty.all(Colors.red.shade200),
      ),
      child: const Text('Validate'),
    );
  }
}
