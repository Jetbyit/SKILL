import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';

class AddJobOffer extends StatefulWidget {
  const AddJobOffer({Key? key}) : super(key: key);

  @override
  State<AddJobOffer> createState() => _AddJobOfferState();
}

class _AddJobOfferState extends State<AddJobOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,//jobportalBrownColor
        elevation: 0,
        leading: Container(),
        title: Text(
          'Add job',
          style: TextStyle(color: jobportalBrownColor),
        ),
      ),
      body: Container(

      ),
    );
  }
}


