import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:yolo/theme_notifier.dart';
import 'package:yolo/widgets/enter_plate_textfield.dart';

class PlateInfoView extends StatefulWidget {
  const PlateInfoView({super.key});

  @override
  State<PlateInfoView> createState() => _PlateInfoViewState();
}

class _PlateInfoViewState extends State<PlateInfoView> {
  final plateController = TextEditingController();
  var vehicleDetail;
  void _fetchDetails() {
    String? input = plateController.text.trim();
    print(input);
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    FirebaseFirestore.instance
        .collection('Number Plate ')
        .doc(input)
        .get()
        .then((value) {
      final data = value.data();
      print(data);
      setState(() {
        vehicleDetail = data;
      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      'Name',
      'Date of Birth',
      'Address',
      'Contact',
      'License No',
      'Class of License',
      'Date of Issue',
      'Expiry Date',
      'Nationality',
      'Model'
    ];

    List<String> values = [
      'Nana Agyeman',
      '6 May 1987',
      'KNUST',
      '+233 24 000 0000',
      'AR 0000 24',
      'B',
      '25 December 2024',
      '25 December 2044',
      'Ghanaian',
      'Range Rover Velar 2025',
    ];

    void validatePlate() {
      print('validate');
      // Validate and fetch plate details
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -18,
                        top: -5,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          onPressed: () {
                            // Handle the back button action
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Center(
                        child: Text(
                          'Plate Information',
                          style: TextStyle(
                            fontSize: 21, // Your preferred font size
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Your preferred color
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              EnterPlateTextField(
                controller: plateController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    _fetchDetails();
                  },
                  child: const Text(
                    'Validate',
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'Poppins',
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: labels.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              labels[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            Text(
                              vehicleDetail?[labels[index]] ?? values[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
