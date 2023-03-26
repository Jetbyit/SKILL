import 'package:cloud_firestore/cloud_firestore.dart';

class JobPosting {
  final String id;
  final String field;
  final String description;
  final String worktype;
  final String location;
  final String budget;
  final Timestamp timestamp;

  JobPosting({
    required this.id,
    required this.field,
    required this.description,
    required this.worktype,
    required this.location,
    required this.timestamp,
    required this.budget,
  });

  factory JobPosting.fromSnapshot(DocumentSnapshot snapshot) {
    return JobPosting(
      id: snapshot.id,
      field: snapshot['field'],
      description: snapshot['description'],
      worktype: snapshot['worktype'],
      location: snapshot['location'],
      timestamp: snapshot['timestamp'],
      budget: snapshot['budget'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'field': field,
      'description': description,
      'worktype': worktype,
      'location': location,
      'timestamp': timestamp,
      'budget': budget,
    };
  }
}
