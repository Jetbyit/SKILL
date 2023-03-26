import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'dart:convert';

import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AddJobOfferUpdated extends StatefulWidget {
  @override
  _AddJobOfferUpdatedState createState() => _AddJobOfferUpdatedState();
}

class _AddJobOfferUpdatedState extends State<AddJobOfferUpdated> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _workType = '';
  String _location = '';
  String _description = '';
  List<String> _locationOptions = [];
  bool _isSending = false;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _worktypeController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _budgetController = TextEditingController();

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

  void _sendJobOffer(String? selectedItem) async {
    //TODO: Implement sending job offer logic
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      JobPosting jobPosting = JobPosting(
        id: '',
        field: selectedItem!,
        description: _descriptionController.text.trim(),
        worktype: _worktypeController.text.trim(),
        location: _locationController.text.trim(),
        timestamp: Timestamp.now(),
        budget: _budgetController.text.trim(),
      );
      JobOfferRepository jobPostingRepository = JobOfferRepository();
      await jobPostingRepository.createJobPosting(jobPosting);
      Navigator.pop(context);
    }
  }

  Future<void> _getLocationOptions() async {
    final response =
        await http.get(Uri.parse('https://example.com/api/locations'));
    final jsonData = json.decode(response.body) as List<dynamic>;
    setState(() {
      _locationOptions =
          jsonData.map((item) => item['name'] as String).toList();
    });
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
        title: const Text('Add Job Offer', style: TextStyle(color: jobportalBrownColor),),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Work type',
                        hintText: 'Enter job type',
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
                      controller: _worktypeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a work type';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _workType = value ?? '';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Location',
                        hintText: 'Enter your work location',
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
                      controller: _locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _location = value ?? '';
                      },
                      onChanged: (value) {
                        setState(() {
                          _location = value;
                        });
                      },
                      // onTap: () async {
                      //   final selectedValue = await showSearch<String>(
                      //     context: context,
                      //     delegate: _LocationSearchDelegate(_locationOptions),
                      //   );
                      //   if (selectedValue != null) {
                      //     setState(() {
                      //       _location = selectedValue;
                      //     });
                      //   }
                      // },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _budgetController,
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
                      maxLines:
                      5, // Set the maximum number of lines to display in the text field
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
                    _sendJobOffer(_selectedItem);
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
      ),
    );
  }
}

class _LocationSearchDelegate extends SearchDelegate<String> {
  final List<String> _locationOptions;

  _LocationSearchDelegate(this._locationOptions);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredOptions = _locationOptions
        .where((option) => option.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredOptions.length,
      itemBuilder: (context, index) {
        final option = filteredOptions[index];
        return ListTile(
          title: Text(option),
          onTap: () => close(context, option),
        );
      },
    );
  }
}
