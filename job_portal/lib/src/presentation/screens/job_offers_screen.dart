import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/data_find_job.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/user_data.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'package:job_portal/src/presentation/screens/apply_form_screen.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:provider/provider.dart';

class JobDetail extends StatefulWidget {
  final JobPosting? job;
  final bool? isEmplyer;

  JobDetail({@required this.job, @required this.isEmplyer});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
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

  @override
  Widget build(BuildContext context) {
    JobOfferRepository jobOfferRepository = JobOfferRepository();
    var userId = FirebaseAuth.instance;
    var uid = Provider.of<UserData>(context, listen: false).currentUserId;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.job!.field,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  //height: 150,
                  //width: MediaQuery.of(context).size.width * 1,
                  child: Icon(
                    getIconForItem(widget.job!.field),
                    size: 48,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Center(
                child: Text(
                  widget.job!.worktype,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  widget.job!.location,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Budget',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text(
                          r"$" + widget.job!.budget,
                          style: TextStyle(
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Requirements",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    widget.job!.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  // Column(
                  //   children: buildRequirements(),
                  // ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  // Container(
                  //   height: 60,
                  //   width: 60,
                  //   child: Center(
                  //     child: IconButton(
                  //       icon: const Icon(
                  //         Icons.bookmark_outline_sharp,
                  //         color: jobportalBrownColor,
                  //       ),
                  //       onPressed: () async {
                  //         // todo: make job saved
                  //         jobOfferRepository.saveJobItem(job!.id);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: widget!.isEmplyer!
                          ? Container()
                          : FutureBuilder<bool>(future: jobOfferRepository.didUserSaveJob(widget.job!.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Icon(
                                    Icons.bookmark_outline_sharp,
                                    color: jobportalBrownColor,
                                  );
                                } else if (snapshot.data == true) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.bookmark_sharp,
                                      color: jobportalBrownColor,
                                    ),
                                    onPressed: () async {
                                      // todo: remove job from saved list
                                      await jobOfferRepository
                                          .removeSavedJob(widget.job!.id);
                                      setState(() {});
                                    },
                                  );
                                } else {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.bookmark_outline_sharp,
                                      color: jobportalBrownColor,
                                    ),
                                    onPressed: () async {
                                      // todo: add job to saved list
                                      await jobOfferRepository
                                          .saveJobItem(widget.job!.id);
                                      setState(() {});
                                    },
                                  );
                                }
                              },
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: widget!.isEmplyer!
                        ? InkWell(
                            onTap: () async {
                              // todo: delete my job
                              final user = FirebaseAuth.instance.currentUser;
                              await FirebaseFirestore
                                  .instance
                                  .collection('job_postings')
                                  .doc(user!.uid)
                                  .collection('myjobs')
                                  .doc(widget.job!.id)
                                  .delete();
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: delet_color,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Delete Offre",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : FutureBuilder<bool?>(
                            future: jobOfferRepository.hasUserAppliedForJob(
                              jobId: widget.job!.id,
                              userId: userId.currentUser!.uid,
                            ),
                            builder: (context, snapshot) {
                              bool? value = snapshot.data;
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              return value!
                                  ? InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: iconColorSecondaryDark,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Already Applied",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ApplyFormScreen(
                                                    jobId: widget.job!.id,
                                                  ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: jobportalBrownColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Apply Now",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildRequirements() {
    List<Widget> list = [];
    for (var i = 0; i < getJobsRequirements().length; i++) {
      list.add(buildRequirement(getJobsRequirements()[i]));
    }
    return list;
  }

  Widget buildRequirement(String requirement) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
            child: Text(
              requirement,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
