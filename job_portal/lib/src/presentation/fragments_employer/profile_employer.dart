import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/dating_model.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/previos_work.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'package:job_portal/src/presentation/widgets/common_cached_image.dart';
import 'package:job_portal/src/presentation/widgets/sidebar_employer.dart';
import 'package:job_portal/src/presentation/widgets/sidebar_user.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileEmployer extends StatefulWidget {
  @override
  ProfileEmployerState createState() => ProfileEmployerState();
}

class ProfileEmployerState extends State<ProfileEmployer> {
  List<PreviosWorkImages> list = getAllListDataSkill();
  JobOfferRepository _jobOfferRepository = JobOfferRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    list.shuffle();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: jobportalBrownColor),
        ),
        backgroundColor: Colors.white, //jobportalBrownColor
        elevation: 0,
        //centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SidebarEmployer(),),);
            },
            icon: const Icon(
              Icons.settings,
              color: jobportalBrownColor,
            ),),
        ],
        leading: const Icon(Icons.person, color: jobportalBrownColor,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                16.height,
                FutureBuilder<EmployerModel>(
                  future: _jobOfferRepository.getInformationEmployer(_auth.currentUser!.uid),
                  builder: (context,  snapshot) {
                    if (snapshot.hasData) {
                      final employerModel = snapshot.data;
                      return Column(
                        children: [
                          CommonCachedNetworkImage(
                            imageUrl: 'https://morningsideplumbing.com/wp-content/uploads/2022/09/Emergency-Plumber-Atlanta.png',
                            height: 150,
                            width: 150,
                          ).cornerRadiusWithClipRRect(75),
                          16.height,
                          Text('Company Name: ${employerModel!.companyName}', style: boldTextStyle()),
                          16.height,
                          Text('Job Location: ${employerModel!.jobLocation}', style: secondaryTextStyle()),
                          16.height,
                          Text('Skills Needed: ${employerModel!.skillsNeeded}', style: secondaryTextStyle()),
                          16.height,
                          Text('Additional Info: ${employerModel!.additionalInfo}', style: secondaryTextStyle()),
                          16.height,
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                AppButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.wifi_tethering_rounded,
                          color: jobportalBrownColor),
                      Text(
                        'Upgrade your profile',
                        style: boldTextStyle(color: jobportalBrownColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(),
                    ],
                  ),
                  width: context.width(),
                  color: iconColorPrimary,
                  onTap: () {
                    //DASettingScreen().launch(context);
                  },
                ),
              ],
            ),
            16.height,
            Text('Bio', style: boldTextStyle(size: 25)),
            16.height,
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s.',
              style: secondaryTextStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            16.height,
          ],
        ).paddingOnly(left: 16, right: 16, bottom: 16),
      ),
    );
  }
}

