import 'package:flutter/material.dart';
import 'package:job_portal/src/utils/colors.dart';

// class ShowSkills extends StatefulWidget {
//   const ShowSkills({Key? key}) : super(key: key);
//
//   @override
//   State<ShowSkills> createState() => _ShowSkillsState();
// }
//
// class _ShowSkillsState extends State<ShowSkills> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,//jobportalBrownColor
//         elevation: 0,
//         leading: Container(),
//         title: Text(
//           'search',
//           style: TextStyle(color: jobportalBrownColor),
//         ),
//       ),
//       body: Container(
//
//       ),
//     );
//   }
// }

class ShowSkills extends StatefulWidget {
  @override
  _ShowSkillsState createState() => _ShowSkillsState();
}

class _ShowSkillsState extends State<ShowSkills> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, //jobportalBrownColor
        elevation: 2,
        leading: const Icon(Icons.stacked_bar_chart_sharp, color: jobportalBrownColor,),
        title: Text(
          'search',
          style: TextStyle(color: jobportalBrownColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.5),
            //         spreadRadius: 1,
            //         blurRadius: 5,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(vertical: 8),
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(15),
            //             child: TextFormField(
            //               controller: _searchController,
            //               textInputAction: TextInputAction.next,
            //               // keyboardType: TextInputType.name,
            //               decoration: const InputDecoration(
            //                 border: InputBorder.none,
            //                 labelStyle: TextStyle(color: Colors.grey),
            //                 //labelText: 'Full Name',
            //                 hintText: 'Search for craftsmen jobs...',
            //                 hintStyle: TextStyle(color: Colors.grey),
            //                 //fillColor: appStore.isDarkModeOn ? context.cardColor : appetitAppContainerColor,
            //                 fillColor: Colors.white,
            //                 filled: true,
            //               ),
            //
            //             ),
            //           ),
            //         ),
            //       ),
            //       // Expanded(
            //       //   child: TextField(
            //       //     controller: _searchController,
            //       //     decoration: InputDecoration(
            //       //       hintText: 'Search for craftsmen jobs...',
            //       //       border: InputBorder.none,
            //       //     ),
            //       //     onSubmitted: (_) {
            //       //       // Perform search here
            //       //     },
            //       //   ),
            //       // ),
            //       IconButton(
            //         icon: Icon(Icons.search),
            //         onPressed: () {
            //           // Perform search here
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextFormField(
                  controller: _searchController,
                  textInputAction: TextInputAction.next,
                  // keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.grey),
                    //labelText: 'Full Name',
                    hintText: 'Search for craftsmen jobs...',
                    hintStyle: TextStyle(color: color_primary_black),
                    //fillColor: appStore.isDarkModeOn ? context.cardColor : appetitAppContainerColor,
                    fillColor: jobportalAppContainerColor,//Colors.white,
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      size: 28,
                      color: color_primary_black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(6),
                //childAspectRatio: 1.3,
                children: const [
                  CraftsmenJob(
                    title: 'Plumber',
                    icon: Icons.build,
                  ),
                  CraftsmenJob(
                    title: 'Electrician',
                    icon: Icons.electrical_services,
                  ),
                  CraftsmenJob(
                    title: 'Carpenter',
                    icon: Icons.precision_manufacturing,
                  ),
                  CraftsmenJob(
                    title: 'Mason',
                    icon: Icons.house_siding,
                  ),
                  CraftsmenJob(
                    title: 'Painter',
                    icon: Icons.format_paint,
                  ),
                  CraftsmenJob(
                    title: 'Welder',
                    icon: Icons.construction,
                  ),
                  CraftsmenJob(
                    title: 'Mechanic',
                    icon: Icons.car_repair,
                  ),
                  CraftsmenJob(
                    title: 'Roofing',
                    icon: Icons.roofing,
                  ),
                  CraftsmenJob(
                    title: 'Landscaping',
                    icon: Icons.landscape,
                  ),
                  CraftsmenJob(
                    title: 'Chef',
                    icon: Icons.restaurant,
                  ),
                  CraftsmenJob(
                    title: 'Tailor',
                    icon: Icons.content_cut,
                  ),
                  CraftsmenJob(
                    title: 'Hairdresser',
                    icon: Icons.perm_contact_calendar_outlined,
                  ),
                  CraftsmenJob(
                    title: 'Photographer',
                    icon: Icons.camera_alt_outlined,
                  ),
                  CraftsmenJob(
                    title: 'Plasterer',
                    icon: Icons.art_track_outlined,
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}

class CraftsmenJob extends StatelessWidget {
  final String title;
  final IconData icon;

  const CraftsmenJob({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.blueGrey,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
