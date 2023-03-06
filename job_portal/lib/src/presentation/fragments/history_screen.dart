import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ASavedFragment extends StatefulWidget {
  const ASavedFragment({Key? key}) : super(key: key);

  @override
  State<ASavedFragment> createState() => _ASavedFragmentState();
}

class _ASavedFragmentState extends State<ASavedFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        backgroundColor: jobportalBrownColor,
        leading: Container(),
      ),
    );
  }
}
