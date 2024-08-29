import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yolo/commons/utils/firebase_methods.dart';
import 'package:yolo/screens/home_page.dart';
import 'package:yolo/screens/login.dart';
import 'package:yolo/theme_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../screens/help_page.dart';
import '../screens/history_page.dart';
import 'theme/dark_theme.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  List<String> items = [
    "item1",
    "item2",
    "item3",
  ];
  String selectedItem = "item1";
  File? _image;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Upload image to Firebase Storage
      final ref = _storage
          .ref()
          .child('profile_images')
          .child('${_auth.currentUser!.uid}.jpg');

      await ref.putFile(_image!);

      // Get the download URL and store it in Firestore
      final url = await ref.getDownloadURL();
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'profileImageUrl': url,
      });
    }
  }
  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  // bool isDarkMode = false;
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Replace the existing Stack for the profile image with the following
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Stack(
                            children: [
                              const SizedBox(
                                height: 70,
                                width: 70,
                                child: CircularProgressIndicator(
                                  color: Colors.blueAccent,
                                  strokeWidth: 10,
                                  value: 0.90,
                                ),
                              ),
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: _image != null
                                    ? FileImage(_image!)
                                        as ImageProvider<Object>
                                    : const AssetImage('assets/images/p.jpeg'),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: -15,
                            right: 3,
                            child: GestureDetector(
                              onTap: _pickImage, // Call the image picker
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Stack(
                      //   clipBehavior: Clip.none,
                      //   children: [
                      //     const Stack(
                      //       children: [
                      //         SizedBox(
                      //           height: 70,
                      //           width: 70,
                      //           child: CircularProgressIndicator(
                      //             color: Colors.blueAccent,
                      //             strokeWidth: 10,
                      //             value: 0.90,
                      //           ),
                      //         ),
                      //         CircleAvatar(
                      //           radius: 35,
                      //           backgroundImage:
                      //               AssetImage('assets/images/p.jpeg'),
                      //         ),
                      //       ],
                      //     ),
                      //     Positioned(
                      //       bottom: -15,
                      //       right: 3,
                      //       child: Container(
                      //         height: 30,
                      //         width: 30,
                      //         decoration: const BoxDecoration(
                      //             color: Colors.grey, shape: BoxShape.circle),
                      //         child: const Padding(
                      //           padding: EdgeInsets.all(5.0),
                      //           child: Icon(
                      //             Icons.add_a_photo,
                      //             color: Colors.white,
                      //             size: 20,
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nana Agyiman",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "apex@mail.com",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildWidget(
                        onTap: () {
                          if (selectedItem != items[0]) {
                            setState(() {
                              selectedItem = items[0];
                            });
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                        selected: selectedItem == items[0],
                        icon: Icon(
                          Icons.home,
                          color: selectedItem == items[0]
                              ? Colors.blue
                              : Colors.black,
                        ),
                        text: "Home"),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildWidget(
                      onTap: () {
                        if (selectedItem != items[1]) {
                          setState(() {
                            selectedItem = items[1];
                          });
                        }
                        // Navigate to the HistoryScreen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const HistoryPage()),
                        );
                      },
                      selected: selectedItem == items[1],
                      icon: Icon(
                        Icons.history,
                        color: selectedItem == items[1]
                            ? Colors.blue
                            : Colors.black,
                      ),
                      text: "History",
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: buildWidget(
                  //       onTap: () {
                  //         if (selectedItem != items[1]) {
                  //           setState(() {
                  //             selectedItem = items[1];
                  //           });
                  //         }
                  //       },
                  //       selected: selectedItem == items[1],
                  //       icon: Icon(
                  //         Icons.history,
                  //         color: selectedItem == items[1]
                  //             ? Colors.blue
                  //             : Colors.black,
                  //       ),
                  //       text: "History"),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildWidget(
                        onTap: () {
                          if (selectedItem != items[2]) {
                            setState(() {
                              selectedItem = items[2];
                            });
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HelpAndFeedbackScreen()),
                          );
                        },
                        selected: selectedItem == items[2],
                        icon: Icon(
                          Icons.help,
                          color: selectedItem == items[2]
                              ? Colors.blue
                              : Colors.black,
                        ),
                        text: "Help & Feedbacks"),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.blue,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "Dark mode",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          themeProvider.changeTheme();
                          setState(() {});
                        },
                        icon: themeProvider.getTheme == darkTheme
                            ? const Icon(Icons.dark_mode)
                            : const Icon(Icons.light_mode),
                      )
                      // Switch.adaptive(
                      //     activeColor: Colors.grey,
                      //     value: themeProvider.getTheme == darkTheme,
                      //     onChanged: (value) {
                      //       themeProvider.changeTheme();
                      //     })
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        authentication.signOut();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.blue,
                            size: 30,
                          ),
                          Text("Logout(Nana Agyiman)"),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildWidget(
    {required Icon icon,
    required String text,
    required bool selected,
    required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      splashColor: Colors.blue,
      tileColor: Colors.grey.shade100,
      selected: selected,
      selectedTileColor: Colors.grey.shade300,
      leading: icon,
      title: Text(
        text,
        style: TextStyle(
            color: selected ? Colors.blue : Colors.black,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
