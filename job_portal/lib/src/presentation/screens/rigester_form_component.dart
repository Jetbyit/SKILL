import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/user_data.dart';
import 'package:job_portal/src/data/models/usermodel.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/data/repositories/auth_repository.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen_employer.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen_skiller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:provider/provider.dart';

class MyForm extends StatefulWidget {
  Worker? worker;
  EmployerModel? employerModel;
  MyForm({Key? key, this.employerModel, this.worker}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final AuthRepository _authRepository = AuthRepository();
  final JobOfferRepository _jobOfferRepository = JobOfferRepository();
  var viewPassword = true;

  Future<String?> _signUpWithEmailAndPassword() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String? userId = await _authRepository.signUpWithEmailAndPassword(email, password);
      Provider.of<UserData>(context, listen: false).currentUserId = userId;
      //Provider.of<UserData>(context, listen: false).user = snapshot.data;
      print("print userId >> ${userId}");
      return userId;

    } catch (e) {
      // handle the exception here
      print('Error signing up with email and password: $e');
      // you can also show a dialog or a snackbar to inform the user about the error
    }
  }

  Future<void> _creatWorkerProfile(String? userId) async {
    if (widget.worker != null && widget.employerModel == null) {
      // todo add information for worker
      try {
        // todo: add type as worker
        await _authRepository.saveUserType(userId, true);
        await _jobOfferRepository
            .creatInformationWorker(widget.worker, userId)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ADashboardSkillerScreen(),
              //todo: ADashboardSkillerScreen(),
              // TODO: ADashboardScreen()
            ),
          );
        });
      } catch (e) {
        print("Error _creatWorkerProfile for Worker : $e");
      }
    } else if (widget.worker == null && widget.employerModel != null) {
      // todo add information for employer
      try {
        // todo: add type as employer
        await _authRepository.saveUserType(userId, false);
        await _jobOfferRepository
            .creatInformationEmployer(widget.employerModel, userId!)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ADashboardEmployerScreen(),
              //  ADashboardEmployerScreen()
              //todo: ADashboardSkillerScreen(),
              // TODO: ADashboardScreen()
            ),
          );
        });
      } catch (e) {
        print("Error _creatWorkerProfile for Employer : $e");
      }
    }
  }

  // todo: upload data for both worker or employer

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          //4 textformfields
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  labelText: 'E-mail',
                  hintText: 'Enter proper email',
                  hintStyle: TextStyle(color: Colors.grey),
                  //fillColor: appStore.isDarkModeOn ? context.cardColor : appetitAppContainerColor,
                  fillColor: context.cardColor,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty)
                    return 'Enter valid Email';
                  else
                    return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: TextFormField(
                obscureText: viewPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                  filled: true,
                  fillColor: context.cardColor,
                  // appStore.isDarkModeOn
                  //     ? context.cardColor
                  //     : appetitAppContainerColor,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => viewPassword = !viewPassword),
                    icon: viewPassword
                        ? Icon(Icons.visibility_off, color: Colors.grey)
                        : Icon(Icons.visibility, color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty)
                    return 'Enter valid Password';
                  else
                    return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: TextFormField(
                obscureText: viewPassword,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  labelText: 'Confirme Password',
                  hintText: 'Enter your Password',
                  filled: true,
                  fillColor: context.cardColor,
                  // appStore.isDarkModeOn
                  //     ? context.cardColor
                  //     : appetitAppContainerColor,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => viewPassword = !viewPassword),
                    icon: viewPassword
                        ? Icon(Icons.visibility_off, color: Colors.grey)
                        : Icon(Icons.visibility, color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty)
                    return 'Enter valid Password';
                  else
                    return null;
                },
              ),
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  await _signUpWithEmailAndPassword().then((value) async {
                    print("value return from _signUpWithEmailAndPassword is : ${value}");
                    await _creatWorkerProfile(value);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully Registered'),
                    ),
                  );
                }
              },
              child: Text('Register', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF2894F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Text(
                'By registering you agree to our',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
