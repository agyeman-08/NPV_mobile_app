import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yolo/commons/utils/firebase_methods.dart';
import 'package:yolo/widgets/enter_plate_textfield.dart';
import 'package:yolo/widgets/validate_plate_button.dart';

class PlateInfoView extends StatelessWidget {
  const PlateInfoView({super.key});

  Future<Map<String, dynamic>> _fetchDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Number Plate')
        .where('user_ID', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception("No details found for the current user");
    }

    DocumentSnapshot doc = querySnapshot.docs.first;
    return doc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController plateController = TextEditingController();
    final FocusNode plateFocusNode = FocusNode();
    List<String> labels = [
      'Name',
      'Date of Birth',
      'Address',
      'Contact',
      'License Number',
      'Class of License',
      'Date of Issue',
      'Expiry Date',
      'Nationality',
      'Model of the Car'
    ];

    List<String> values = [
      'Nana Agyeman Akosua',
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

    void validatePlate() async {
      final plateNumber = plateController.text.trim();
      if (plateNumber.isEmpty) {
        // Show an error message if the plate number is empty
        print('Please enter a plate number');
        return;
      }

      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('Number Plate')
            .doc(plateNumber)
            .get();

        if (!doc.exists) {
          print('No details found for the entered plate number');
        } else {
          // Display the fetched data
          print('Document data: ${doc.data()}');
          // You can also set the state to update the UI with the fetched data
        }
      } catch (e) {
        print('Error fetching details: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plate Information'),
        centerTitle: true,
        backgroundColor: const Color(0xFFfffefe),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          plateFocusNode.unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFfffefe),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                // Container(
                //   width: 240,
                //   decoration: const BoxDecoration(
                //     color: Color(0xffbfbfbe),
                //     borderRadius: BorderRadius.all(Radius.circular(18)),
                //   ),
                //   child: const Center(
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: 18),
                //       child:
                //       Text(
                //         'AR - 0000 - 24',
                //         style: TextStyle(
                //           fontSize: 20,
                //           color: Color(0xFFfffefe),
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // EnterPlateTextField(
                //   controller: plateController,
                //   focusNode: plateFocusNode,
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: plateController,
                    focusNode: plateFocusNode,
                    decoration: const InputDecoration(
                      hintText: "AR-0000-24",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      plateController.text = value.toUpperCase();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ValidatePlateButton(onPressed: validatePlate),
                const SizedBox(height: 20),

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: plateController.text.trim() == null
                        ? null
                        : FirebaseFirestore.instance
                            .collection('Number Plate')
                            .where('Plate Number',
                                isEqualTo: plateController.text.trim())
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No details found for this plate number'),
                        );
                      } else {
                        final doc = snapshot.data!.docs.first;
                        return ListView(
                          children: [
                            Text(
                              'Name: ${doc['Name']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Date of Birth: ${doc['Date of Birth']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Address: ${doc['Address']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Contact: ${doc['Contact']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'License Number: ${doc['License Number']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Class of License: ${doc['Class of License']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Date of Issue: ${doc['Date of Issue']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Expiry Date: ${doc['Expiry Date']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Nationality: ${doc['Nationality']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Model of the Car: ${doc['Model of the Car']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                // Expanded(
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: labels.length,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.only(bottom: 18),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 labels[index],
                //                 style: const TextStyle(
                //                   fontSize: 14,
                //                 ),
                //               ),
                //               Text(
                //                 values[index],
                //                 style: const TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
