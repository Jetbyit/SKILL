import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/dating_model.dart';
import 'package:job_portal/src/data/models/previos_work.dart';
import 'package:job_portal/src/presentation/widgets/common_cached_image.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AProfileFragment extends StatefulWidget {
  @override
  AProfileFragmentState createState() => AProfileFragmentState();
}

class AProfileFragmentState extends State<AProfileFragment> {
  List<PreviosWorkImages> list = getAllListDataSkill();

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
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: jobportalBrownColor,
              ),),
        ],
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                16.height,
                CommonCachedNetworkImage(
                  imageUrl:
                      'https://morningsideplumbing.com/wp-content/uploads/2022/09/Emergency-Plumber-Atlanta.png',
                  height: 150,
                  width: 150,
                ).cornerRadiusWithClipRRect(75),
                16.height,
                Text('John Doe', style: boldTextStyle()),
                16.height,
                Text('Email: john.doe@example.com',
                    style: secondaryTextStyle()),
                16.height,
                Text('Phone: (123) 456-7890', style: secondaryTextStyle()),
                16.height,
                Text('Location: New York, NY', style: secondaryTextStyle()),
                16.height,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Skill', style: boldTextStyle(size: 25)),
                Text('Add skill',
                    style: primaryTextStyle(color: jobportalBrownColor))
                    .onTap(
                      () {
                    //DAProfileViewAllScreen().launch(context);
                    print("DAProfileViewAllScreen().launch(context);");
                  },
                ),
              ],
            ),
            Wrap(
              children: List.generate(10, (index) {
                Color color = Colors.primaries[index % Colors.primaries.length];
                List<String> skills = [
                  "Knowledge of plumbing systems",
                  "analyze",
                  "Attention to detail",
                  "Physical strength and stamina",
                  "Communication skills",
                  "Time management skills",
                  "Knowledge of safety regulations",
                  "Customer service skills",
                  "Technical skills",
                  "Attention to hygiene",
                ];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text('${skills[index]}',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: color,
                    deleteIcon: Icon(Icons.cancel, color: Colors.white),
                    onDeleted: () {
                      // Do something when the cancel button is pressed
                    },
                  ),
                );
              }),
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Previous work', style: boldTextStyle()),
                Text('View All',
                        style: primaryTextStyle(color: jobportalBrownColor))
                    .onTap(
                  () {
                    //DAProfileViewAllScreen().launch(context);
                    print("DAProfileViewAllScreen().launch(context);");
                  },
                ),
              ],
            ),
            16.height,
            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: list.take(12).map(
                (e) {
                  return CommonCachedNetworkImage(
                    imageUrl: e.imageUrl,
                    fit: BoxFit.cover,
                    height: 100,
                    width: (context.width() / 3) - 22,
                  ).cornerRadiusWithClipRRect(10).onTap(() {
                    print("DAZoomingScreen(img: e.image).launch(context);");
                  }, highlightColor: white, splashColor: white);
                },
              ).toList(),
            ),
          ],
        ).paddingOnly(left: 16, right: 16, bottom: 16),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class AProfileFragment extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Profile'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           SizedBox(height: 20),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   'Personal Information',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//               Card(
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Colors.grey,
//                     backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/75.jpg'),
//                   ),
//                   title: Text(
//                     'Full Name',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'John Doe',
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Email: john.doe@example.com',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Phone: (123) 456-7890',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Location: New York, NY',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//                 ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text('Full Name'),
//                   subtitle: Text('John Doe'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.email),
//                   title: Text('Email Address'),
//                   subtitle: Text('johndoe@email.com'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.phone),
//                   title: Text('Phone Number'),
//                   subtitle: Text('+1 555-123-4567'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.location_on),
//                   title: Text('Location'),
//                   subtitle: Text('New York, NY'),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Work Experience',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'Company Name',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Job Title',
//                           style: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Job Description',
//                           style: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Duration of Employment',
//                           style: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Notable Achievements and Responsibilities',
//                           style: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Education',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ListTile(
//                   leading: Icon(Icons.school),
//                   title: Text('School'),
//                   subtitle: Text('University of XYZ'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.book),
//                   title: Text('Degree'),
//                   subtitle: Text('Bachelor of Science in Computer Science'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.date_range),
//                   title: Text('Year of Graduation'),
//                   subtitle: Text('2015'),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Skills',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ListTile(
//                   leading: Icon(Icons.code),
//                   title: Text('Technical Skills'),
//                   subtitle: Text('Java, Python, HTML, CSS, Flutter'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.face),
//                   title: Text('Soft Skills'),
//                   subtitle: Text(
//                       'Communication, Problem-solving, Time management'),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Certifications and Licenses',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ListTile(
//                   leading: Icon(Icons.card_membership),
//                   title: Text('Certification/License'),
//                   subtitle: Text(
//                       'Certified Information Systems Security Professional (CISSP)'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.date_range),
//                   title: Text('Date of Issuance'),
//                   subtitle: Text('June 2018'),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.account_balance),
//                   title: Text('Issuing Organization'),
//                   subtitle: Text(
//                       'International Information System Security Certification Consortium (ISC)²'),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Projects and Portfolios',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'Project Title',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Project Description',
//                           style: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Link to Project',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Personal Statement',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'I am a highly motivated individual with a passion for software development. My career goal is to become a leading expert in the field and develop innovative solutions to complex problems. In my free time, I enjoy playing soccer and learning new programming languages.',
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
