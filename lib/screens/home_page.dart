import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yolo/screens/LicenseDetailsScreen.dart';
import 'package:yolo/screens/input_page.dart';
import 'package:yolo/theme_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:yolo/widgets/activity_card.dart';
import 'package:yolo/widgets/drawer.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yolo/commons/server.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _imageFile;
  String? _profileImageUrl;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  /// Fetch the profile image URL from Firestore
  Future<void> _loadProfileImage() async {
    try {
      final userDoc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      setState(() {
        _profileImageUrl = userDoc.data()?['profileImageUrl'] as String?;
      });
    } catch (e) {
      debugPrint("Error loading profile image: $e");
    }
  }

  /// Capture an image using the device camera
  Future<void> captureImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        await _uploadProfileImage();
      }
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  Future<void> sendImage(File imageFile) async {
    try {
      String base64Image = base64Encode(imageFile.readAsBytesSync());
      String apiKey = 'PSk8ognDA4rqALw6UC1g';
      String modelEndpoint = 'ocr_gh_licenseplate/1';
      String uploadURL =
          'https://detect.roboflow.com/$modelEndpoint?api_key=$apiKey';

      final response = await http.post(
        Uri.parse(uploadURL),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: base64Image,
      );

      if (response.statusCode == 200) {
        var inferenceResponse = json.decode(response.body);
        double xValue = inferenceResponse["predictions"][0]["x"];
        double yValue = inferenceResponse["predictions"][0]["y"];
        double wValue = inferenceResponse["predictions"][0]["width"];
        double hValue = inferenceResponse["predictions"][0]["height"];

        var plateNum =
            await serverDetect(imageFile.path, xValue, yValue, wValue, hValue);

        print(plateNum);

        // Navigate to the new screen and pass the plate number
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LicenseDetailsScreen(plateNum: plateNum),
          ),
        );
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  /// Select an image from the gallery
  Future<void> uploadImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        sendImage(File(pickedFile.path)!);
      }
    } catch (e) {
      debugPrint("Error uploading image: $e");
    }
  }

  /// Upload the selected image to Firebase Storage and update Firestore
  Future<void> _uploadProfileImage() async {
    if (_imageFile == null) return;

    try {
      final ref = _storage
          .ref()
          .child('profile_images')
          .child('${_auth.currentUser!.uid}.jpg');

      // Upload file
      await ref.putFile(_imageFile!);

      // Get the download URL
      final url = await ref.getDownloadURL();

      // Update Firestore with the new image URL
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'profileImageUrl': url});

      setState(() {
        _profileImageUrl = url;
      });
    } catch (e) {
      debugPrint("Error uploading profile image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 25,
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
                GestureDetector(
                  onTap:
                      uploadImage, // Allow tapping to change the profile picture
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: _profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                        : const AssetImage('assets/images/wadlle.jpg')
                            as ImageProvider,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            // Select an activity text
            const Text(
              'Select an activity',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 30),
            // Activity column
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Capture
                    GestureDetector(
                      onTap: captureImage,
                      child: const ActivityCard(
                        icon: Icons.photo_camera,
                        text: 'Capture',
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Upload
                    GestureDetector(
                      onTap: uploadImage,
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
