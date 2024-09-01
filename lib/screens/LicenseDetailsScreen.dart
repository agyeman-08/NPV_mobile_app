import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LicenseDetailsScreen extends StatefulWidget {
  final String plateNum;

  const LicenseDetailsScreen({super.key, required this.plateNum});

  @override
  State<LicenseDetailsScreen> createState() => _LicenseDetailsScreenState();
}

class _LicenseDetailsScreenState extends State<LicenseDetailsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? licenseData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLicenseDetails();
  }

  /// Fetch license details from Firestore
  Future<void> _fetchLicenseDetails() async {
    try {
      // Clean the plate number by removing spaces or other characters
      String cleanedPlateNum = _cleanPlateNumber(widget.plateNum);

      final collection = _firestore.collection('Number Plate ');
      final mydata = await collection.get();
      for (var doc in mydata.docs) {
        print('Document ID: ${doc.id}');
        print('Document Data: ${doc.data()}');
      }
      // Fetch documents where the 'Plate Number' exactly matches the cleanedPlateNum
      final querySnapshot = await collection
          .where('Plate Number', isEqualTo: widget.plateNum)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          licenseData = querySnapshot.docs.first.data();
          isLoading = false;
        });
      } else {
        setState(() {
          licenseData = null; // No details found
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching license details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Helper function to check if the plate number format is valid
  bool _isValidPlateNumberFormat(String plateNumber) {
    // Regular expression to match the format (e.g., AB1234-12)
    RegExp regex = RegExp(r'^[A-Z]{2}\d{4}-\d{2}$');
    return regex.hasMatch(plateNumber);
  }

  /// Clean the plate number input by removing unwanted characters and formatting it
  String _cleanPlateNumber(String plateNum) {
    return plateNum.replaceAll(RegExp(r'[^A-Z0-9-]'), '').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // Cleaned plate number for display
    String cleanedPlateNum = _cleanPlateNumber(widget.plateNum);

    return Scaffold(
      appBar: AppBar(
        title: const Text('License Details'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : licenseData == null
              ? const Center(child: Text('No details found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Plate Number: $cleanedPlateNum'),
                      Text('Name: ${licenseData!['Name']}'),
                      Text('Date of Birth: ${licenseData!['Date of Birth']}'),
                      Text('Address: ${licenseData!['Address']}'),
                      Text('Contact: ${licenseData!['Contact']}'),
                      Text('License No: ${licenseData!['License No']}'),
                      Text(
                          'Class of License: ${licenseData!['Class of License']}'),
                      Text('Date of Issue: ${licenseData!['Date of Issue']}'),
                      Text('Expiry Date: ${licenseData!['Expiry Date']}'),
                      Text('Nationality: ${licenseData!['Nationality']}'),
                      Text('Model: ${licenseData!['Model']}'),
                    ],
                  ),
                ),
    );
  }
}
