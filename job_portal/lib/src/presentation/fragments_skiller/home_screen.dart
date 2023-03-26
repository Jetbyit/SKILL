import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/data_find_job.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'package:job_portal/src/presentation/screens/job_offers_screen.dart';
import 'package:job_portal/src/utils/colors.dart';

///craftsmen professions
class AHomeFragment extends StatefulWidget {
  @override
  _AHomeFragmentState createState() => _AHomeFragmentState();
}

class _AHomeFragmentState extends State<AHomeFragment> {
  List<Job> jobs = getJobs();
  JobOfferRepository _jobOfferRepository = JobOfferRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();
  List<JobPosting> _searchResults = [];


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

  Future<void> _performSearch() async {
    String searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      List<JobPosting> results = await _jobOfferRepository.searchJobPostingsByDescription(searchTerm);
      ///List<JobPosting> seconResults = await _jobOfferRepository.getJobPostings();
      print("_searchResults now is : ${results}");
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: jobportalBrownColor),
          ),
          backgroundColor: Colors.white, //jobportalBrownColor
          elevation: 0,
          //centerTitle: true,
          leading: const Icon(
            Icons.home,
            color: jobportalBrownColor,
          ),
          // actions: const [
          //   Icon(
          //     Icons.search,
          //     size: 28,
          //     color: jobportalBrownColor,
          //   ),
          //   SizedBox(
          //     width: 24,
          //   ),
          //   Icon(
          //     Icons.filter_list,
          //     size: 28,
          //     color: jobportalBrownColor,
          //   ),
          //   SizedBox(
          //     width: 24,
          //   ),
          // ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .77,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by field ex : painter',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: (){
                                    if(_searchController.text.trim().isNotEmpty && _searchController.text.trim() != null){
                                      _performSearch();
                                    }
                                  },
                                ),
                              ),
                              onChanged: (value){
                                print("value is changed real time : $value");
                                setState(() {
                                  isSearching = false;
                                });
                              },
                              onSubmitted: (value){
                                print("value on submit field is : $value test if value is empty >> ${value.isEmpty}");
                                if(_searchController.text.trim().isNotEmpty && _searchController.text.trim() != null){
                                  setState(() {
                                    isSearching = true;
                                  });
                                  _performSearch();
                                }
                              },
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(
                          Icons.filter_list,
                          size: 22,
                          color: jobportalBrownColor,
                        ),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 32, left: 32, top: 8, bottom: 20),
                      child: Text(
                        "Craftsmen\nProfessions",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    //   child: Wrap(
                    //     crossAxisAlignment: WrapCrossAlignment.start,
                    //     spacing: 16,
                    //     runSpacing: 16,
                    //     children: [
                    //       buildFilterOption("Electrician"),
                    //       buildFilterOption("Perth"),
                    //       buildFilterOption(r"$30 - 50h"),
                    //       buildFilterOption("Part-Time"),
                    //     ],
                    //   ),
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: Text(
                        "Recommended for you",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 190,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildRecommendations(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: Text(
                        "Recently added",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: FutureBuilder(
                        future: _jobOfferRepository.getJobPostings(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          var jobObjects = snapshot.data;
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return isSearching ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                JobPosting jobPosting = _searchResults[index];
                                return jobDetails(jobPosting);
                              },
                            ): ListView.builder(
                                shrinkWrap: true,
                                itemCount: jobObjects.length,
                                itemBuilder: (context, index) {
                                  var data = jobObjects[index];
                                  return buildLastJob(data);
                                },
                            );
                            return ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                JobPosting jobPosting = _searchResults[index];
                                return jobDetails(jobPosting);
                              },
                            );
                          }
                        },
                      ),
                      // Column(
                      //   children: buildLastJobs(),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterOption(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.clear,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecommendations() {
    List<Widget> list = [];
    list.add(const SizedBox(
      width: 32,
    ));
    for (var i = 0; i < jobs.length; i++) {
      list.add(buildRecommendation(jobs[i]));
    }
    list.add(const SizedBox(
      width: 16,
    ));
    return list;
  }

  Widget buildRecommendation(Job job) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => JobDetail(job: job)),
        // );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(job.logo),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage(job.logo),
                    //   fit: BoxFit.fitWidth,
                    // ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      job.concept,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    job.position,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: iconColorPrimary,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    r"$" + job.price + "/h",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: iconColorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecommendationTest(JobPosting job) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => JobDetail(job: job)),
        // );
      },
      child: Container(
        width: 200,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   image: DecorationImage(
        //     image: AssetImage(job.logo),
        //     fit: BoxFit.cover,
        //   ),
        //   borderRadius: const BorderRadius.all(
        //     Radius.circular(10),
        //   ),
        // ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 75,
                  width: 75,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage(job.logo),
                    //   fit: BoxFit.fitWidth,
                    // ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      job.worktype,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    job.field,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: iconColorPrimary,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    r"$" + job.budget.toString() + "/h",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: iconColorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildLastJobs() {
    // List<Widget> list = [];
    // for (var i = jobs.length - 1; i > -1; i--) {
    //   list.add(buildLastJob(jobs[i]));
    // }
    // return list;
    List<Widget> list = [];
    list.add(const SizedBox(
      width: 32,
    ));
    // var jobsRef = FirebaseFirestore.instance.collection('job_postings').snapshots().forEach((el) {
    //       JobPosting job = JobPosting.fromSnapshot(el);
    //       print('job is : ${job.budget}');
    //       list.add(buildLastJob(job));
    // });
    // jobsRef.get().then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((DocumentSnapshot document) async {
    //     JobPosting job = await JobPosting.fromSnapshot(document);
    //     print('job is : ${job.budget}');
    //     list.add(buildLastJob(job));
    //   });
    // });
    list.add(const SizedBox(
      width: 16,
    ));
    list.add(const Text(
      'width: 16',
    ));
    return list;
  }

  Widget buildLastJob(JobPosting? job) {
    return FutureBuilder<JobPosting>(
      future: _jobOfferRepository.getJobItemPostings(job!.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var data = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return  jobDetails(job);
        }
      },
    );
  }

  Widget jobDetails(JobPosting? job){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetail(job: job)),
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
              child:Container(
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
                child: Icon(getIconForItem(job!.field), size: 48,),
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
}
