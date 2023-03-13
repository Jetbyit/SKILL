import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/data_find_job.dart';
import 'package:job_portal/src/presentation/screens/job_offers_screen.dart';
import 'package:job_portal/src/utils/colors.dart';


///craftsmen professions
class AHomeFragment extends StatefulWidget {
  @override
  _AHomeFragmentState createState() => _AHomeFragmentState();
}

class _AHomeFragmentState extends State<AHomeFragment> {

  List<Job> jobs = getJobs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: jobportalBrownColor),),
        backgroundColor: Colors.white,//jobportalBrownColor
        elevation: 0,
        //centerTitle: true,
        //leading: Container(),
        actions: const [
          Icon(
            Icons.search,
            size: 28,
            color: jobportalBrownColor,
          ),

          SizedBox(
            width: 24,

          ),

          Icon(
            Icons.filter_list,
            size: 28,
            color: jobportalBrownColor,
          ),
          SizedBox(
            width: 24,

          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Padding(
                    padding: EdgeInsets.only(right: 32, left: 32, top: 8, bottom: 20),
                    child: Text(

                      "Craftsmen\nProfessions",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.2
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        buildFilterOption("Electrician"),
                        buildFilterOption("Perth"),
                        buildFilterOption(r"$30 - 50h"),
                        buildFilterOption("Part-Time"),
                      ],
                    ),
                  ),

                  Padding(
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

                  Padding(
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
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: buildLastJobs(),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterOption(String text){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8,),
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

  List<Widget> buildRecommendations(){
    List<Widget> list = [];
    list.add(SizedBox(width: 32,));
    for (var i = 0; i < jobs.length; i++) {
      list.add(buildRecommendation(jobs[i]));
    }
    list.add(SizedBox(width: 16,));
    return list;
  }

  Widget buildRecommendation(Job job){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetail(job: job)),
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(job.logo),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 16),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4,),
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

  List<Widget> buildLastJobs(){
    List<Widget> list = [];
    for (var i = jobs.length - 1; i > -1; i--) {
      list.add(buildLastJob(jobs[i]));
    }
    return list;
  }

  Widget buildLastJob(Job job){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetail(job: job)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
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
              child:
              //AssetImage(job.logo),
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(job.logo),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
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
                        job.position,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        job.company,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),

                    ],
                  ),
                )
            ),

            Text(
              r"$" + job.price + "/h",
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