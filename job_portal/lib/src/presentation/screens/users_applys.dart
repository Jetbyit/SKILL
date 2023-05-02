import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_portal/src/presentation/fragments_skiller/profile_screen.dart';
import 'package:job_portal/src/presentation/screens/profile_visit.dart';

class UsersApplys extends StatefulWidget {
  final String jobId;

  UsersApplys({required this.jobId});

  @override
  _UsersApplysState createState() => _UsersApplysState();
}

class _UsersApplysState extends State<UsersApplys> {
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    print("widget.jobId in initState is : ${widget.jobId}");
    _usersStream = FirebaseFirestore.instance
        .collection('job_applys')
        .doc(widget.jobId)
        .collection('user_applys')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users who applied'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text('No users applied yet');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String userId = data['userId'];
              return ListTile(
                title: Text('user name : $userId'),
                subtitle: const Text('user address'),
                leading: const CircleAvatar(
                  radius: 50.0,
                  backgroundImage:
                      AssetImage('assets/images/welecom/logo_skills.jpg'),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                  ),
                ),
                onTap: () {
                  // todo: go into user worker profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AProfileVisiting(peeruserId: userId),
                    ),
                  );
                },
              );

              return ListTile(
                title: Text(userId),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
