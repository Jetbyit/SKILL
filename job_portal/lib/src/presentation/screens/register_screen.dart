import 'package:flutter/material.dart';
import 'package:job_portal/src/presentation/screens/login_screen.dart';
import 'package:job_portal/src/presentation/screens/rigester_form_component.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:job_portal/src/utils/colors.dart';

class ARegisterScreen extends StatefulWidget {
  const ARegisterScreen({Key? key}) : super(key: key);

  @override
  _ARegisterScreenState createState() => _ARegisterScreenState();
}

class _ARegisterScreenState extends State<ARegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    //color: appStore.isDarkModeOn ? context.cardColor : appetitAppContainerColor,
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: 50,
                  height: 50,
                  child: InkWell(
                    child: Icon(Icons.arrow_back_ios_outlined, color: jobportalBrownColor),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ALoginScreen())),
                  child: Text('Login', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: context.iconColor)),
                ),
              ],
            ),
            SizedBox(height: 60),
            Text('Register', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700)),
            SizedBox(height: 16),
            Text('Create your account now! Fill in your information to start using our app and explore its features.'),
            SizedBox(height: 8),
            MyForm(),
          ],
        ),
      ),
    );
  }
}
