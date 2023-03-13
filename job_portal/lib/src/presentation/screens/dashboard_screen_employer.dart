import 'package:flutter/material.dart';
import 'package:job_portal/src/presentation/fragments_employer/add_job.dart';
import 'package:job_portal/src/presentation/fragments_employer/profile_employer.dart';
import 'package:job_portal/src/presentation/fragments_employer/show_skills.dart';
import 'package:job_portal/src/utils/colors.dart';

class ADashboardEmployerScreen extends StatefulWidget {
  ADashboardEmployerScreen({Key? key}) : super(key: key);

  @override
  State<ADashboardEmployerScreen> createState() => _ADashboardEmployerScreenState();
}

class _ADashboardEmployerScreenState extends State<ADashboardEmployerScreen> {
  int selectedItem = 0;

  void onTapSelection(int index) {
    if (index == 1) {
     Navigator.push(context, MaterialPageRoute(builder: (context) => AddJobOffer()));
    }
    else setState(() => selectedItem = index);
  }

  List<Widget> widgetOption = <Widget>[
    ShowSkills(),
    AddJobOffer(),
    ProfileEmployer(),
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
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: jobportalBrownColor,
                ),
                child: Icon(Icons.add, size: 40, color: Colors.white),
              ),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, size: 30),
              label: 'Profile',
            ),
          ],
        ),

    );
  }
}
