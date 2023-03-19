import 'package:flutter/material.dart';
import 'package:job_portal/src/presentation/screens/walkthrough_screen.dart';
import 'package:job_portal/src/presentation/screens/welecom_screen.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/presentation/screens/dashboard_screen_employer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SKILL',
      theme: ThemeData(
        primarySwatch: Colors.brown,//jobportalBrownColor,
      ),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (!snapshot.hasData) {
            // Loading screen while waiting for shared preferences to load
            return Center(child: CircularProgressIndicator());
          } else {
            SharedPreferences prefs = snapshot.data!;
            bool hasSeenWalkthrough = prefs.getBool('hasSeenWalkthrough') ?? false;
            if (hasSeenWalkthrough) {
              // User has already seen the walkthrough, show the home page
              // todo: write
              return AWelcomeScreen();//ADashboardEmployerScreen();
            } else {
              // User has not seen the walkthrough, show it
              return WalkthroughScreen(
                onDismiss: () {
                  prefs.setBool('hasSeenWalkthrough', true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AWelcomeScreen()),
                  );
                },
              );
            }
          }
        },
      ),
      ///WalkthroughScreen(),
    );
  }
}