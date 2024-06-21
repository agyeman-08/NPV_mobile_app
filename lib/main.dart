import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolo/firebase_options.dart';
// import 'package:yolo/screens/landing_page.dart';
import 'package:yolo/screens/splash.dart';
import 'package:yolo/theme_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeBool = prefs.getBool("isDark") ?? false;
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeProvider(isDark: themeBool),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Page',
        theme: themeProvider.getTheme,
        // theme: ThemeData(
        //   scaffoldBackgroundColor:
        //       Colors.grey[700], // Set scaffold background color to grey[700]
        //   appBarTheme: AppBarTheme(
        //     backgroundColor: Colors
        //         .grey[700], // Set app bar background color to match scaffold
        //   ),
        //   elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all<Color>(Colors
        //           .tealAccent), // Use tealAccent for elevated button background
        //     ),
        //   ),
        //   textTheme: const TextTheme(
        //     titleLarge: TextStyle(
        //       color: Colors.white, // Set text color for headlines to white
        //       fontSize: 24.0, // Set font size for headlines
        //     ),
        //     // Add more text styles as needed
        //   ),
        //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
        //       .copyWith(secondary: Colors.tealAccent),
        // ),
        home: const SplashScreen(),
      );
    });
  }
}
