import 'package:cloud_firestore/cloud_firestore.dart';

class JobPosting {
  final String id;
  final String title;
  final String description;
  final String skills;
  final double compensation;
  final String location;
  final String contact;

  JobPosting({
    required this.id,
    required this.title,
    required this.description,
    required this.skills,
    required this.compensation,
    required this.location,
    required this.contact,
  });

  factory JobPosting.fromSnapshot(DocumentSnapshot snapshot) {
    return JobPosting(
      id: snapshot.id,
      title: snapshot['title'],
      description: snapshot['description'],
      skills: snapshot['skills'],
      compensation: snapshot['compensation'].toDouble(),
      location: snapshot['location'],
      contact: snapshot['contact'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'skills': skills,
      'compensation': compensation,
      'location': location,
      'contact': contact,
    };
  }
}
