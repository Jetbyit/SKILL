import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_portal/src/data/models/usermodel.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen_skiller.dart';
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
  late Worker? _worker;
  late TextEditingController? name;
  late TextEditingController? address;
  late TextEditingController? previousWork;
  late TextEditingController? skills;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _worker = Worker(
      id: '',
      previousWorkExperience: '',
      name: '',
      address: '',
      skills: [],
    );
    name = TextEditingController();
    address = TextEditingController();
    previousWork = TextEditingController();
    skills = TextEditingController();
  }

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
                        color: jobportalAppContainerColor, //context.cardColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: 40,
                      height: 40,
                      child: InkWell(
                        child: Icon(Icons.arrow_back_ios_outlined,
                            color: jobportalBrownColor),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Text('I have a skill',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: jobportalBrownColor)),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ALoginScreen())),
                      child: Text('Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: jobportalBrownColor)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewPadding.top * 4),
                CustomTextField(
                  labelText: 'Full Name',
                  hintText: 'Enter Full Name',
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    print("value is : ${value}");
                    _worker!.name = value!;
                    //print("_worker!.name in value save is : ${_worker!.name}");
                  },
                ),
                CustomTextField(
                  labelText: 'Address',
                  hintText: 'Enter your street here',
                  controller: address,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    print("value is : ${value}");
                    _worker!.address = value!;
                  },
                ),
                CustomTextField(
                  labelText: 'Previous Work Experience',
                  hintText: 'Previous work experience',
                  controller: previousWork,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your previous work experience';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    print("value is : ${value}");
                    _worker!.previousWorkExperience = value!;
                  },
                ),
                CustomTextField(
                  labelText: 'Skills {separate with (,)}',
                  hintText: 'Enter yourr skills here',
                  controller: skills,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skills';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    print("value is : ${value}");
                    _worker!.skills =
                        value!.split(',').map((e) => e.trim()).toList();
                  },
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Process and submit form data to database
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Successfully Uploaded'),
                          ),
                        );
                        // todo: collect information data
                        Worker worker = Worker(
                          id: '1',
                          name: name!.text.trim(),
                          address: address!.text.trim(),
                          previousWorkExperience: previousWork!.text.trim(),
                          skills: skills!.text.split(','),
                        );
                        print("worker extract informations : ${worker.skills}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ARegisterScreen(
                              worker: worker,
                              employerModel: null,
                            ),
                            // TODO: ADashboardScreen()
                          ),
                        );
                      }
                    },
                    child: Text('Submit', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF2894F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
