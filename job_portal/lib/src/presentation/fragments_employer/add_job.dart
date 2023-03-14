// import 'package:flutter/material.dart';
// import 'package:job_portal/src/utils/colors.dart';
//
// class AddJobOffer extends StatefulWidget {
//   const AddJobOffer({Key? key}) : super(key: key);
//
//   @override
//   State<AddJobOffer> createState() => _AddJobOfferState();
// }
//
// class _AddJobOfferState extends State<AddJobOffer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//       AppBar(
//         backgroundColor: Colors.white,//jobportalBrownColor
//         elevation: 0,
//         leading: Container(),
//         title: Text(
//           'Add job',
//           style: TextStyle(color: jobportalBrownColor),
//         ),
//       ),
//       body: Container(
//
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AddJobOffer extends StatefulWidget {
  const AddJobOffer({Key? key}) : super(key: key);

  @override
  _AddJobOfferState createState() => _AddJobOfferState();
}

class _AddJobOfferState extends State<AddJobOffer> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  TextEditingController _jobSkillsController = TextEditingController();
  TextEditingController _jobCompensationController = TextEditingController();
  TextEditingController _jobLocationController = TextEditingController();
  TextEditingController _jobContactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,//jobportalBrownColor
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.cancel_outlined, color: jobportalBrownColor,),
        ),
        title: Text(
          'Add job',
          style: TextStyle(color: jobportalBrownColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:
            Container(
              height: MediaQuery.of(context).size.height * .8,
              child: Form(
                key: _formKey,
                child: Stepper(
                  currentStep: _currentStep,
                  onStepContinue: () {
                    setState(() {
                      if (_currentStep < 6 - 1) {
                        _currentStep += 1;
                      } else {
                        // Submit form
                      }
                    });
                  },
                  onStepCancel: () {
                    setState(() {
                      if (_currentStep > 0) {
                        _currentStep -= 1;
                      } else {
                        _currentStep = 0;
                      }
                    });
                  },
                  steps: [
                    Step(
                      title: Text('Job Title'),
                      content: TextFormField(
                        controller: _jobTitleController,
                        decoration: InputDecoration(
                          labelText: 'Enter job title',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter job title';
                          }
                          return null;
                        },
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: Text('Job Description'),
                      content: TextFormField(
                        controller: _jobDescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Enter job description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter job description';
                          }
                          return null;
                        },
                      ),
                      isActive: _currentStep >= 1,
                      state:
                      _currentStep >= 1 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: Text('Job Skills'),
                      content: TextFormField(
                        controller: _jobSkillsController,
                        decoration: InputDecoration(
                          labelText: 'Enter required job skills',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter required job skills';
                          }
                          return null;
                        },
                      ),
                      isActive: _currentStep >= 2,
                      state:
                      _currentStep >= 2 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: Text('Job Compensation'),
                      content: TextFormField(
                        controller: _jobCompensationController,
                        decoration: InputDecoration(
                          labelText: 'Enter job compensation',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter job compensation';
                          }
                          return null;
                        },
                      ),
                      isActive: _currentStep >= 3,
                      state:
                      _currentStep >= 3 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: Text('Job Location'),
                      content: TextFormField(
                        controller: _jobLocationController,
                        decoration: InputDecoration(
                          labelText: 'Enter job location',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter job location';
                          }
                          return null;
                        },
                      ),
                      isActive: _currentStep >= 4,
                      state:
                      _currentStep >= 4 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: Text('Job Contact'),
                      content: TextFormField(
                        controller: _jobContactController,
                        decoration: InputDecoration(
                          labelText: 'Enter job contact information',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter job contact information';
                          }
                          return null;
                        },
                      ),
                      isActive: _currentStep >= 5,
                      state:
                      _currentStep >= 5 ? StepState.complete : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButton(
              width: context.width(),
              color: jobportalAppContainerColor,
              onTap: () {
                //DASettingScreen().launch(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.cloud_upload_outlined, color: jobportalBrownColor,),
                  Text(
                    'Upload your offer',
                    style: boldTextStyle(color: jobportalBrownColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
