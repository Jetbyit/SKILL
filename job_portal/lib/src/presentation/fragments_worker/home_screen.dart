import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';

class AHomeFragment extends StatelessWidget {
  const AHomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: jobportalBrownColor),),
        backgroundColor: Colors.white,//jobportalBrownColor
        elevation: 0,
        centerTitle: true,
        leading: Container(),
      ),
      body: Container(),
    );
  }
}
