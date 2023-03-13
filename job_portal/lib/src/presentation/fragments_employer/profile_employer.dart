import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';

class ProfileEmployer extends StatefulWidget {
  const ProfileEmployer({Key? key}) : super(key: key);

  @override
  State<ProfileEmployer> createState() => _ProfileEmployerState();
}

class _ProfileEmployerState extends State<ProfileEmployer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,//jobportalBrownColor
        elevation: 0,
        leading: Container(),
        title: Text(
          'Profile',
          style: TextStyle(color: jobportalBrownColor),
        ),
      ),
      body: Container(

      ),
    );
  }
}


