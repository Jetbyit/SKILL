import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:job_portal/src/utils/colors.dart';

class ASavedFragment extends StatelessWidget {
  final List<Map<String, dynamic>> savedItems = [
    {
      'name': 'John Doe',
      'hours': 8,
      'date': '2022-03-01',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'name': 'Jane Smith',
      'hours': 6,
      'date': '2022-03-02',
      'image': 'https://picsum.photos/200/301'
    },
    {
      'name': 'Bob Johnson',
      'hours': 4,
      'date': '2022-03-03',
      'image': 'https://picsum.photos/201/300'
    },
    {
      'name': 'Alice Williams',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://picsum.photos/202/301'
    },
    {
      'name': 'Alice Williams',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://picsum.photos/203/301'
    },
    {
      'name': 'Alice Williams',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://picsum.photos/204/301'
    },
    {
      'name': 'Alice Williams',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://picsum.photos/205/301'
    },
    {
      'name': 'Alice Williams',
      'hours': 5,
      'date': '2022-03-04',
      'image': 'https://picsum.photos/206/301'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('History', style: TextStyle(color: jobportalBrownColor),),
        backgroundColor: iconColorPrimary,
        leading: Container(),
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
