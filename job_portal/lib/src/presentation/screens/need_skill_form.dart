import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen_skiller.dart';
import 'package:job_portal/src/presentation/screens/login_screen.dart';
import 'package:job_portal/src/presentation/screens/register_screen.dart';
import 'package:job_portal/src/presentation/widgets/custom_textwidget.dart';
import 'package:job_portal/src/utils/colors.dart';

class EmployerForm extends StatefulWidget {
  @override
  _EmployerFormState createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late EmployerModel? _employer;
  late TextEditingController? _companyName;
  late TextEditingController? _skillsnedded;
  late TextEditingController? _jobLocation;
  late TextEditingController? _additionalInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employer = EmployerModel(
      additionalInfo: '',
      companyName: '',
      jobLocation: '',
      skillsNeeded: [],
    );
    _companyName = TextEditingController();
    _skillsnedded = TextEditingController();
    _jobLocation = TextEditingController();
    _additionalInfo = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
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
                    Text('I need a skill', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: jobportalBrownColor)),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ALoginScreen())),
                      child: Text('Login', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: jobportalBrownColor)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewPadding.top * 4 ),
                CustomTextField(
                  labelText: 'Company Name',
                  hintText: 'Enter Company Name',
                  controller: _companyName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your company name';
                    }
                    return null;
                  },
                  onSaved: (value) => _employer!.companyName = value!,
                ),
                CustomTextField(
                  labelText: 'Skills Nedded',
                  hintText: 'Enter skills nedded',
                  controller: _skillsnedded,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skills nedded';
                    }
                    return null;
                  },
                  onSaved: (value) => _employer!.skillsNeeded = value!.split(',').map((e) => e.trim()).toList(),
                ),
                CustomTextField(
                  labelText: 'Company Location',
                  hintText: 'Enter address of your company',
                  controller: _jobLocation,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address of your company';
                    }
                    return null;
                  },
                  onSaved: (value) => _employer!.jobLocation = value!,
                ),

                CustomTextField(
                  labelText: 'Additional Information',
                  hintText: 'Additional information for your company',
                  controller: _additionalInfo,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter information for your company';
                    }
                    return null;
                  },
                  onSaved: (value) => _employer!.additionalInfo = value!,
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
                          SnackBar(content: Text('Successfully Uploaded'),
                          ),
                        );
                        EmployerModel employer = EmployerModel(
                          companyName: _companyName!.text.trim(),
                          jobLocation: _jobLocation!.text.trim(),
                          additionalInfo: _additionalInfo!.text.trim(),
                          skillsNeeded: _skillsnedded!.text.split(','),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ARegisterScreen(
                              employerModel: employer,
                              worker: null,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 18)),
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
