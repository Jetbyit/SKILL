
import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AProfileFragment extends StatefulWidget {
  const AProfileFragment({Key? key}) : super(key: key);

  @override
  State<AProfileFragment> createState() => _AProfileFragmentState();
}

class _AProfileFragmentState extends State<AProfileFragment> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: jobportalBrownColor,
        leading: Container(),
      ),
    );
  }
}
