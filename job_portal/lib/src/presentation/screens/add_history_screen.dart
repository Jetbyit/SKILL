import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal/src/data/models/history_model.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/repositories/history__rpository.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AddJobHistoryWorker extends StatefulWidget {
  @override
  _AddJobHistoryWorkerState createState() => _AddJobHistoryWorkerState();
}

class _AddJobHistoryWorkerState extends State<AddJobHistoryWorker> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _titlework = '';
  String _delai = '';
  String _description = '';
  List<String> _locationOptions = [];
  bool _isSending = false;
  File? _imageFile;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleworkController = TextEditingController();
  TextEditingController _delaitotlaController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();


  List<String> _items = [
    'Electrician',
    'Plumber',
    'Carpenter',
    'Painter',
    'Landscaper',
    'Mason',
    'Roofing contractor',
    'HVAC technician',
    'Flooring specialist',
    'Drywall installer',
    'Welder',
    'Metalworker',
    'Blacksmith',
    'Sculptor',
    'Potter',
    'Glassblower',
    'Jeweler',
    'Tailor',
    'Shoemaker',
    'Woodworker'
  ];

  void _sendJobOffer() async {
    //TODO: Implement sending job offer logic
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      HistoryRepository historyRepository = HistoryRepository();
      await historyRepository.addDataToFirebase(
        workdesc: _descriptionController.text.trim(),
        hours: _delaitotlaController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        title: _titleworkController.text.trim(),
        imageFile: _imageFile,
      );
      Navigator.pop(context);
    }
  }

  /// final imageFile = await pickImage();

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
    return null;
  }


  @override
  void initState() {
    super.initState();
    // _getLocationOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add work history', style: TextStyle(color: jobportalBrownColor),),
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
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Work title',
                        hintText: 'Enter Work title',
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
                      controller: _titleworkController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title of work';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _titlework = value ?? '';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Deali ',
                        hintText: 'Enter your delai of work here',
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
                      controller: _delaitotlaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _delai = value ?? '';
                      },
                      onChanged: (value) {
                        setState(() {
                          _delai = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Upload your image'),
                        IconButton(onPressed: () {
                          // todo: image picker method
                          pickImage();
                        }, icon: const Icon(Icons.image)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter job description',
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
                      controller: _descriptionController,
                      maxLines: 5, // Set the maximum number of lines to display in the text field
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value ?? '';
                      },
                    ),
                  ),
                ],
              ),
            ),
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
                    _sendJobOffer();
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
                      'Upload your history',
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
      ),
    );
  }
}