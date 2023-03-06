import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';

class AMessageFragment extends StatefulWidget {
  const AMessageFragment({Key? key}) : super(key: key);

  @override
  State<AMessageFragment> createState() => _AMessageFragmentState();
}

class _AMessageFragmentState extends State<AMessageFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
        centerTitle: true,
        backgroundColor: jobportalBrownColor,
        leading: Container(),
      ),
    );
  }
}
