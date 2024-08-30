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
  /// Fetch license details from Firestore
  Future<void> _fetchLicenseDetails() async {
    try {
      // Clean the plate number by removing spaces or other characters
      String cleanedPlateNum =
          widget.plateNum.replaceAll(RegExp(r'[^0-9-]'), '');

      final querySnapshot = await _firestore
          .collection('Number Plate ')
          .where('Plate Number', isEqualTo: cleanedPlateNum)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          licenseData = querySnapshot.docs.first.data();
          isLoading = false;
        });
      } else {
        setState(() {
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

  @override
  Widget build(BuildContext context) {
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
