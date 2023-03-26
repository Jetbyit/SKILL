import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ApplyFormScreen extends StatefulWidget {
  String? jobId;
  ApplyFormScreen({this.jobId});
  @override
  _ApplyFormScreenState createState() => _ApplyFormScreenState();
}

class _ApplyFormScreenState extends State<ApplyFormScreen> {
  late final TextEditingController _addressController = TextEditingController();
  late final TextEditingController _skillsController = TextEditingController();
  late final TextEditingController _previousWorksController = TextEditingController();
  late final JobOfferRepository _jobOfferRepository;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSending = false;

  Future<void> prepareTextFields() async {
    var _auth = await FirebaseAuth.instance;
    Worker workerInformation =
    await _jobOfferRepository.getInformationWorkder(_auth.currentUser!.uid);
    _addressController.text = workerInformation.address;
    _skillsController.text = workerInformation.skills.toString();
    _previousWorksController.text = workerInformation.previousWorkExperience;
  }

  void _applyForOffer() async {
    //TODO: Implement sending job offer logic
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      var _auth = await FirebaseAuth.instance;
      Worker workerInformation = await _jobOfferRepository.getInformationWorkder(_auth.currentUser!.uid);
      Worker worker = Worker(
        id: workerInformation.id,
        name: workerInformation.name,
        previousWorkExperience: workerInformation.previousWorkExperience,
        address: workerInformation.address,
        skills: workerInformation.skills,
      );
      JobOfferRepository jobPostingRepository = JobOfferRepository();
      await jobPostingRepository.applyForJobOffer(
        jobId: widget.jobId,
        userId: _auth.currentUser!.uid,
        worker: worker,
      );
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _jobOfferRepository = JobOfferRepository();
    prepareTextFields();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _skillsController.dispose();
    _previousWorksController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for offer', style: TextStyle(color: jobportalBrownColor),),
        backgroundColor: Colors.white,//jobportalBrownColor
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.cancel_outlined, color: jobportalBrownColor,),
        ),
        bottom: _isSending
            ? const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: LinearProgressIndicator(
            color: Colors.brown,
          ),
        )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _addressController,
                decoration:InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your addres',
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: jobportalAppContainerColor,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _skillsController,
                decoration:InputDecoration(
                  labelText: 'Skills',
                  hintText: 'Enter your skills',
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: jobportalAppContainerColor,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter skills here';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _previousWorksController,
                decoration:InputDecoration(
                  labelText: 'Previous work',
                  hintText: 'Enter previous work',
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: jobportalAppContainerColor,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter previous work here';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton(
                  width: context.width(),
                  color: jobportalAppContainerColor,
                  onTap: () async {
                    // DASettingScreen().launch(context);
                    setState(() {
                      _isSending = true;
                    });
                    // Submit form
                    try {
                      // todo: add function to load data here
                      _applyForOffer();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('An error occurred while adding the job offer.'),
                        ),
                      );
                    } finally {
                      setState(() {
                        _isSending = false;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.cloud_upload_outlined,
                        color: jobportalBrownColor,
                      ),
                      Text(
                        'Apply for offer',
                        style: boldTextStyle(color: jobportalBrownColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Save the data and navigate back to the previous screen
              //     final address = _addressController.text;
              //     final skills = _skillsController.text;
              //     final previousWorks = _previousWorksController.text;
              //     Navigator.pop(context, {'address': address, 'skills': skills, 'previousWorks': previousWorks});
              //   },
              //   child: Text('Save'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
