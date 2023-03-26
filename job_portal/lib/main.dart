import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/user_data.dart';
import 'package:job_portal/src/data/repositories/auth_repository.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen_skiller.dart';
import 'package:job_portal/src/presentation/screens/splachscreen.dart';
import 'package:job_portal/src/presentation/screens/walkthrough_screen.dart';
import 'package:job_portal/src/presentation/screens/welecom_screen.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'src/presentation/screens/dashboard_screen_employer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserData>(
          create: (context) => UserData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthRepository _authRepository = AuthRepository();
  bool _didNavigate = false;
  Widget _getScreenId() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        if (snapshot.hasData) {
          Provider.of<UserData>(context, listen: false).currentUserId = snapshot!.data!.uid;
          //Provider.of<UserData>(context, listen: false).user = snapshot.data;
          //var typeUser = _authRepository.getUserType(snapshot!.data!.uid);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // todo: choice between worker screen and employer screen
            bool? typeUser = await _authRepository.getUserType(snapshot!.data!.uid);
            if (!_didNavigate) {
              if(typeUser!){
                // todo: navigate into worker dash screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => ADashboardSkillerScreen()));
              }else{
                // todo:  navigate into employer dash screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => ADashboardEmployerScreen()));
              }
              _didNavigate = true;
            }
          });
          return SplashScreen();
        } else {
          //return SignInSignUPScreen();
          print(' tu es sur SplashScreen De: SignInSignUPScreen() retour ${FirebaseAuth.instance.currentUser}');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // todo: choice between worker screen and employer screen
            if (!_didNavigate) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AWelcomeScreen()));
              _didNavigate = true;
            }
          });
          return SplashScreen();
        }
      },
    );
  }

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
              return _getScreenId();//ADashboardEmployerScreen();
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