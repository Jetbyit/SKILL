import 'package:flutter/material.dart';
import 'package:job_portal/src/presentation/fragments_worker/history_screen.dart';
import 'package:job_portal/src/presentation/fragments_worker/home_screen.dart';
import 'package:job_portal/src/presentation/fragments_worker/messages_screen.dart';
import 'package:job_portal/src/presentation/fragments_worker/profile_screen.dart';
import 'package:job_portal/src/presentation/fragments_worker/search_screen.dart';
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
    AHomeFragment(),
    AMessageFragment(),
    //ASearchFragment(),
    ASavedFragment(),
    AProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOption.elementAt(selectedItem),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          backgroundColor: iconColorPrimary,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedItem,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: onTapSelection,
          elevation: 0,
          selectedItemColor: jobportalBrownColor,
          unselectedItemColor: jobportalAppContainerColor,
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
