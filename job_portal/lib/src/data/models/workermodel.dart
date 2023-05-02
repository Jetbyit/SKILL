import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  String id;
  String name;
  String previousWorkExperience;
  String address;
  String? bio;
  String? jobTitle;
  String? imageUrl;
  List<String> skills;

  Worker({
    required this.id,
    required this.name,
    required this.previousWorkExperience,
    required this.address,
    required this.skills,
    this.jobTitle,
    this.imageUrl,
    this.bio,
  });

  factory Worker.fromJson(DocumentSnapshot json) {
    return Worker(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      jobTitle: json['jobTitle'],
      previousWorkExperience: json['previousWorkExperience'],
      bio: json['bio'],
      imageUrl: json['imageUrl'],
      skills: List<String>.from(json['skills']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'imageUrl': imageUrl,
      "previousWorkExperience": previousWorkExperience,
      'skills': skills,
      'bio': bio,
      'jobTitle': jobTitle,
    };
  }
}
