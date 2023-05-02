import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_portal/src/data/models/user_data.dart';
import 'package:job_portal/src/data/models/usermodel.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/presentation/screens/dashboard_screen_skiller.dart';
import 'package:job_portal/src/presentation/screens/login_screen.dart';
import 'package:job_portal/src/presentation/screens/register_screen.dart';
import 'package:job_portal/src/presentation/widgets/custom_textwidget.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController _skillsFormController = TextEditingController();
  List<String> _skillsMethods = [];

  void _addSkills() {
    String skillMethod = _skillsFormController.text.trim();
    if (skillMethod.isNotEmpty) {
      setState(() {
        _skillsMethods.add(skillMethod);
        _skillsFormController.clear();
      });
    }
  }

  void _removeSkillMethod(int index) {
    setState(() {
      _skillsMethods.removeAt(index);
    });
  }

  File? _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  String? _selectedItem;

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _worker = Worker(
      id: '',
      previousWorkExperience: '',
      name: '',
      address: '',
      bio: '',
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
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
                    Padding(
                      padding: const EdgeInsets.all(26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Field', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          DropdownButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            value: _selectedItem,
                            items: _items
                                .map((item) => DropdownMenuItem<String>(
                              child: Chip(
                                label: Text(item),
                                avatar: Icon(Icons.circle),
                                backgroundColor: Colors.primaries[_items
                                    .indexOf(item) %
                                    Colors.primaries
                                        .length], // Replace with specific icon for each item
                              ),
                              value: item,
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              CustomTextField(
                labelText: 'Skills {separate with (,)}',
                hintText: 'Enter yourr skills here',
                controller: _skillsFormController, //skills,
                suffixIcon: IconButton(onPressed: (){_addSkills();}, icon: Icon(Icons.add)),
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter your skills';
                //   }
                //   return null;
                // },
                onSaved: (value) {
                  print("value is : ${value}");
                  _worker!.skills = _skillsMethods!;//.split(',').map((e) => e.trim()).toList();
                },
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                  _skillsMethods.length,
                      (index) => Chip(
                    label: Text(_skillsMethods[index]),
                    onDeleted: () => _removeSkillMethod(index),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox (
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
                      for (String skill in _skillsMethods) {
                        _skillsFormController.text += skill + ", ";
                      }
                      print('_selectedItem is : $_selectedItem');
                      Worker worker = Worker(
                        id: '1',
                        name: name!.text.trim(),
                        address: address!.text.trim(),
                        jobTitle: _selectedItem,
                        previousWorkExperience: previousWork!.text.trim(),
                        skills: _skillsFormController!.text.split(','),
                        bio: "",
                        imageUrl: "",
                      );
                      print("worker extract informations : ${worker.skills}");
                      // _image != null ? _uploadImage : null;
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
    );
  }
}
