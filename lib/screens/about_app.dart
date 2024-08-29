import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                'A license plate validation app uses optical \ncharacter recognition (OCR) and image processing to automate the recognition and \nverification of vehicle license plates. It captures plate information from \nimages or live camera feeds, converting visual data into digital text. The app then validates this information against specific regional rules and formats, such as character count and patterns\n The app also helps to upload images to be verified by the databse.\nDesigned for use in areas like law enforcement, parking management, and access control, the app quickly verifies plates and identifies vehicles of interest. A user-friendly interface allows easy image uploads or live scans, with clear results displayed to the user.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
