
import 'package:flutter/material.dart';
import 'package:job_portal/src/presentation/fragments/history_screen.dart';
import 'package:job_portal/src/presentation/fragments/home_screen.dart';
import 'package:job_portal/src/presentation/fragments/messages_screen.dart';
import 'package:job_portal/src/presentation/fragments/profile_screen.dart';
import 'package:job_portal/src/presentation/fragments/search_screen.dart';
import 'package:job_portal/src/utils/colors.dart';

class ADashboardScreen extends StatefulWidget {
  ADashboardScreen({Key? key}) : super(key: key);

  @override
  State<ADashboardScreen> createState() => _ADashboardScreenState();
}

class _ADashboardScreenState extends State<ADashboardScreen> {
  int selectedItem = 0;

  void onTapSelection(int index) {
    // if (index == 2) {
    //   //todo: Navigator.push(context, MaterialPageRoute(builder: (context) => AAddRecipeScreen()));
    // }
    // else
    setState(() => selectedItem = index);
  }

  List<Widget> widgetOption = <Widget>[
    const AHomeFragment(),
    const AMessageFragment(),
    //ASearchFragment(),
    const ASavedFragment(),
    const AProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOption.elementAt(selectedItem),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          backgroundColor: jobportalBrownColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedItem,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: onTapSelection,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 30),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history, size: 30),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, size: 30),
              label: 'Profile',
            ),
          ],
        )

    );
  }
}
