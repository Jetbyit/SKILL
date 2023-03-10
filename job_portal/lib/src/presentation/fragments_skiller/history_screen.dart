import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:job_portal/src/utils/colors.dart';

class ASavedFragment extends StatelessWidget {
  final List<Map<String, dynamic>> savedItems = [
    {
      'name': 'Install and repair pipes and fixtures: This involves installing, repairing, and maintaining various types of plumbing systems, including water, gas, and sewage systems.',
      'hours': 8,
      'date': '2022-03-01',
      'image': 'https://empire-s3-production.bobvila.com/articles/wp-content/uploads/2021/07/how_much_does_a_plumber_cost.jpg'
    },
    {
      'name': 'Clear clogs and blockages',
      'hours': 6,
      'date': '2022-03-02',
      'image': 'https://centraheat.co.uk/wp-content/uploads/2021/03/What-can-a-plumber-fix-for-me.jpg'
    },
    {
      'name': 'Install and repair water heaters: Plumbers install and repair a variety of water heaters, including tankless, electric, and gas models.',
      'hours': 4,
      'date': '2022-03-03',
      'image': 'https://www.mickbutler-andson.co.uk/wp-content/uploads/2016/03/Jobs-That-Need-a-Plumber-Norwich.jpg'
    },
    {
      'name': 'Fix leaks.',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'http://www.rainsoftneiowa.com/wp-content/uploads/2020/08/Plumbing-Expert.jpg'
    },
    {
      'name': 'Install and repair water treatment systems: Plumbers may install and repair water ',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://homefixituae.com/wp-content/uploads/2022/02/plumbers-near-me.jpg'
    },
    {
      'name': 'Respond to emergencies.',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://www.ableskills.co.uk/wp/wp-content/uploads/2021/10/A-day-in-the-life-of-a-plumber.jpg'
    },
    {
      'name': 'Install and repair pipes and fixtures',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://www.scoutnetworkblog.com/wp-content/uploads/2017/12/Plumber-Fixes-Washroom-Sink-Drains-With-Tools.jpg'
    },
    {
      'name': 'Fix leaks',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://homefixituae.com/wp-content/uploads/2022/02/plumbers-near-me.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: const Text('History', style: TextStyle(color: jobportalBrownColor),),
        backgroundColor: iconColorPrimary,
        //leading: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        onPressed: () {
          // TODO: Implement action for floating action button
        },
        child: Icon(Icons.add, size: 28,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            cacheExtent: 2.5,
            itemCount: savedItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          savedItems[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            savedItems[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text('Hours of work: ${savedItems[index]['hours']}'),
                          SizedBox(height: 4.0),
                          Text('Date: ${savedItems[index]['date']}'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            //staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            ),
      ),
    );
  }
}
