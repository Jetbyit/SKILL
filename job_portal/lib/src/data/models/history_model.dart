import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryWork {
  final String id;
  final String workdesc;
  final String title;
  final String delaiwork;
  //final File imageFile;
  final String imageUrl;
  final Timestamp timestamp;

  HistoryWork({
    required this.id,
    required this.workdesc,
    required this.title,
    required this.delaiwork,
    required this.timestamp,
    //required this.imageFile,
    required this.imageUrl,
  });

  factory HistoryWork.fromSnapshot(DocumentSnapshot snapshot) {
    return HistoryWork(
      id: snapshot.id,
      workdesc: snapshot['workdesc'],
      delaiwork: snapshot['delaiwork'],
      title: snapshot['title'],
      timestamp: snapshot['timestamp'],
      imageUrl: snapshot['imageUrl'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'worktype': workdesc,
      'delaiwork': delaiwork,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
      'title': title,
    };
  }
}
