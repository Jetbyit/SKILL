
import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ASearchFragment extends StatefulWidget {
  ASearchFragment({Key? key}) : super(key: key);

  @override
  State<ASearchFragment> createState() => _ASearchFragmentState();
}

class _ASearchFragmentState extends State<ASearchFragment> with SingleTickerProviderStateMixin {
  late PageController pageController = PageController(initialPage: 0);

  var selectedItem = 0;

  void onTapAction(index) {
    setState(() => selectedItem = index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          title: const Text('History', style: TextStyle(color: jobportalBrownColor),),
          backgroundColor: iconColorPrimary,
          leading: const Icon(Icons.search, color: jobportalBrownColor,),
        ),
      ),
    );
  }
}
