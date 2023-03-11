import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen.dart';
import 'package:job_portal/src/presentation/screens/login_screen.dart';
import 'package:job_portal/src/presentation/screens/register_screen.dart';
import 'package:job_portal/src/presentation/widgets/custom_textwidget.dart';
import 'package:job_portal/src/utils/colors.dart';

class JobSeekerFormScreen extends StatefulWidget {
  @override
  _JobSeekerFormScreenState createState() => _JobSeekerFormScreenState();
}

class _JobSeekerFormScreenState extends State<JobSeekerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Fields
  String? _fullName;
  String? _email;
  String? _phone;
  String? _address;
  DateTime? _dob;
  String? _educationLevel;
  String? _areaOfStudy;
  String? _school;
  String? _degree;
  String? _previousWorkExperience;
  String? _skills;
  String? _resume;
  String? _jobPreferences;
  String? _workLocation;
  String? _salaryExpectations;
  String? _availability;
  String? _additionalInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //color: appStore.isDarkModeOn ? context.cardColor : appetitAppContainerColor,
                        color: jobportalAppContainerColor,//context.cardColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: 40,
                      height: 40,
                      child: InkWell(
                        child: Icon(Icons.arrow_back_ios_outlined, color: jobportalBrownColor),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Text('I have a skill', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: jobportalBrownColor)),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ALoginScreen())),
                      child: Text('Login', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: jobportalBrownColor)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewPadding.top * 4 ),
                CustomTextField(
                  labelText: 'Full Name',
                  hintText: 'Enter Full Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onSaved: (value) => _fullName = value,
                ),
                CustomTextField(
                  labelText: 'Address',
                  hintText: 'Enter your street here',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onSaved: (value) => _address = value,
                ),
                CustomTextField(
                  labelText: 'Previous Work Experience',
                  hintText: 'Previous work experience',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your previous work experience';
                    }
                    return null;
                  },
                  onSaved: (value) => _previousWorkExperience = value,
                ),
                CustomTextField(
                  labelText: 'Skills',
                  hintText: 'Enter yourr skills here',

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skills';
                    }
                    return null;
                  },
                  onSaved: (value) => _skills = value,
                ),
                CustomTextField(
                  labelText: 'Resume/CV',
                  hintText: 'Upload your resume',

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your resume or CV';
                    }
                    return null;
                  },
                  onSaved: (value) => _resume = value,
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      //   // Process and submit form data to database
                      // }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Successfully Uploaded'),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ARegisterScreen(),
                          // TODO: ADashboardScreen()
                        ),
                      );
                    },
                    child: Text('Submit', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF2894F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
