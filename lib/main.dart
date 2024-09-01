import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolo/firebase_options.dart'; // Update with your correct path
import 'package:yolo/screens/input_page.dart';
import 'package:yolo/screens/splash.dart'; // Update with your correct path
import 'package:yolo/theme_notifier.dart'; // Update with your correct path
import 'plate_info_view.dart'; // Import PlateInfoView

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize SharedPreferences for theme settings
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeBool = prefs.getBool("isDark") ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(isDark: themeBool),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Set your design size here
      minTextAdapt: true,
      builder: (context, child) {
        return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'License Plate Info',
            theme: themeProvider.getTheme,
            home: const SplashScreen(), // Start with the SplashScreen
            routes: {
              '/plateInfo': (context) => const PlateInfoView(),
              '/splash': (context) => const SplashScreen(),
              // Add more routes if needed
            },
          );
        });
      },
    );
  }
}
