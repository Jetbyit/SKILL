import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/workermodel.dart';

class ListOfWorkers extends StatefulWidget {
  final String? title;
  const ListOfWorkers({Key? key, this.title}) : super(key: key);

  @override
  State<ListOfWorkers> createState() => _ListOfWorkersState();
}

class _ListOfWorkersState extends State<ListOfWorkers> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Worker>?>? getWorkersByJobTitle(String jobTitle) async {
    final querySnapshot = await firestore
        .collection('workers')
        .where('jobTitle', isEqualTo: jobTitle)
        .get();
    final workers = querySnapshot.docs.map((doc) =>
        Worker(
          id: doc.id,
          name: doc['name'],
          jobTitle: doc['jobTitle'],
          bio: doc['bio'],
          imageUrl: doc['imageUrl'],
          previousWorkExperience: doc['previousWorkExperience'],
          skills: List<String>.from(doc['skills']),
          address: doc['address'],
        )).toList();
    return workers;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget!.title!),
        actions: [
          // todo: filter button by two main option (review and stars - works done)
          IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list, color: Colors.white,)),
        ],
      ),
      body: FutureBuilder<List<Worker?>?>(
        future: getWorkersByJobTitle(widget!.title!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final workers = snapshot.data!;
              return ListView.builder(
                itemCount: workers.length,
                itemBuilder: (context, index) {
                  final worker = workers[index];
                  return ListTile(
                    title: Text(worker!.name),
                    subtitle: Text(worker!.skills.join(', ')),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(worker!.imageUrl!),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
