
import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AHomeFragment extends StatefulWidget {
  const AHomeFragment({Key? key}) : super(key: key);

  @override
  State<AHomeFragment> createState() => _AHomeFragmentState();
}

class _AHomeFragmentState extends State<AHomeFragment> {
  var bookmarkSelection = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: jobportalBrownColor,
        leading: Container(),
      ),
    );
  }
}
