import 'package:flutter/material.dart';

class PlateInfoView extends StatelessWidget {
  const PlateInfoView({super.key});
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plate Information'),
        centerTitle: true,
        backgroundColor: const Color(0xFFfffefe),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFfffefe),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Container(
                width: 240,
                decoration: const BoxDecoration(
                  color: Color(0xffbfbfbe),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'AR - 0000 - 24',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFfffefe),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
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
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              values[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
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
