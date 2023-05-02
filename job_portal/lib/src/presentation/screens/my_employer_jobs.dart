import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/user_data.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'package:job_portal/src/presentation/screens/job_offers_screen.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:provider/provider.dart';

class MyJobPosted extends StatefulWidget {
  @override
  State<MyJobPosted> createState() => _MyJobPostedState();
}

class _MyJobPostedState extends State<MyJobPosted> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String? currentUserId = Provider.of<UserData>(context, listen: false).currentUserId;
    print("currentUserId is : $currentUserId");
    JobOfferRepository _jobOfferRepository = JobOfferRepository();
    IconData getIconForItem(String item) {
      switch (item) {
        case 'Electrician':
          return Icons.electrical_services;
        case 'Plumber':
          return Icons.plumbing;
        case 'Carpenter':
          return Icons.construction;
        case 'Painter':
          return Icons.palette;
        case 'Landscaper':
          return Icons.nature_people;
        case 'Mason':
          return Icons.format_shapes;
        case 'Roofing contractor':
          return Icons.house_siding;
        case 'HVAC technician':
          return Icons.ac_unit;
        case 'Flooring specialist':
          return Icons.local_florist;
        case 'Drywall installer':
          return Icons.home_repair_service;
        case 'Welder':
          return Icons.build;
        case 'Metalworker':
          return Icons.extension;
        case 'Blacksmith':
          return Icons.fireplace;
        case 'Sculptor':
          return Icons.account_balance_outlined;
        case 'Potter':
          return Icons.celebration_rounded;
        case 'Glassblower':
          return Icons.local_drink;
        case 'Jeweler':
          return Icons.color_lens;
        case 'Tailor':
          return Icons.design_services;
        case 'Shoemaker':
          return Icons.accessibility;
        case 'Woodworker':
          return Icons.wb_sunny;
        default:
          return Icons.help_outline;
      }
    }

    Widget jobDetails(JobPosting? job) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobDetail(job: job, isEmplyer: true)),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage(job.logo),
                    //   fit: BoxFit.fitWidth,
                    // ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Icon(
                    getIconForItem(job!.field),
                    size: 48,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job!.worktype,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      job!.field,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )),
              Text(
                r"$" + job!.budget.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Jobs Offre',
          style: TextStyle(color: jobportalBrownColor),
        ),
        backgroundColor: Colors.white, //jobportalBrownColor
        elevation: 3,
        leading: const Icon(
          Icons.bookmark,
          color: jobportalBrownColor,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('job_postings')
            .doc(currentUserId)
            .collection('myjobs')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final jobIds = snapshot.data!.docs.map((doc) => doc.id).toList();
            return ListView.builder(
              itemCount: jobIds.length,
              itemBuilder: (context, index) {
                final jobId = jobIds[index];
                return Dismissible(
                  key: Key(jobId),
                  onDismissed: (direction) async {
                    // Display an alert to confirm deletion
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete job posting'),
                          content: Text(
                              'Are you sure you want to delete this job posting?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                // Re-add the job posting to the list if the user cancels deletion
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () async {
                                // Get a reference to the "saved_items" collection in Firestore
                                final savedItemsRef = FirebaseFirestore.instance
                                    .collection('job_postings')
                                    .doc(currentUserId);
                                // Delete the document for the current user's ID in the "users_saved" subcollection of the "saved_items" document
                                await savedItemsRef
                                    .collection('myjobs')
                                    .doc(jobId)
                                    .delete();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  background: Container(color: Colors.red),
                  child: FutureBuilder<JobPosting>(
                    future: _jobOfferRepository.getJobItemPostings(jobId),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var job = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Container());
                      } else if (snapshot.hasError) {
                        return Text('Error inside function: ${snapshot.error}');
                      } else {
                        return jobDetails(job);
                      }
                    },
                  ),
                );
                //return Text(jobId, style: const TextStyle(color: Colors.black),);
              },
            );
          }
        },
      ),
    );
  }
}
