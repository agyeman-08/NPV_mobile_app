import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yolo/screens/input_page.dart';

import 'package:yolo/widgets/activity_card.dart';
import 'package:yolo/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? capturedImage;

  Future captureImage() async {
    await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future uploadImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // User's name
                    Text(
                      'Nana',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xff24C3B4),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/wadlle.jpg'),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            // select an activity text
            const Text(
              'Select an activity',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 30),
            // activity column
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Capture
                    GestureDetector(
                      onTap: () {
                        captureImage();
                      },
                      child: const ActivityCard(
                        icon: Icons.photo_camera,
                        text: 'Capture',
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Upload
                    GestureDetector(
                      onTap: () {
                        uploadImage();
                      },
                      child: const ActivityCard(
                        icon: Icons.upload,
                        text: 'Upload',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Input
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const PlateInfoView();
                        },
                      ),
                    );
                  },
                  child: const ActivityCard(
                    icon: Icons.keyboard,
                    text: 'Input',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
