import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/workermodel.dart';

class JobPostingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> uploadJobPosting(JobPosting jobPosting) async {
    DocumentReference docRef = await _firestore.collection('job_postings').add(jobPosting.toMap());
    await docRef.update({'id': docRef.id});
  }

  Future<List<JobPosting>> getJobPostings() async {
    final jobPostings = await _firestore.collection('job_postings').get();
    return jobPostings.docs.map((doc) => JobPosting.fromSnapshot(doc)).toList();
  }

  Future<void> creatInformationWorkder(Worker? worker) async {
    DocumentReference docRef = await _firestore.collection('workers').add(worker!.toJson());
    await docRef.update({'id': docRef.id});
  }

  Future getInformationWorkder(Worker? worker) async {
    final jobPostings = await _firestore.collection('worker').get();

  }

  Future<void> creatInformationEmployer(EmployerModel? employerModel) async {
    DocumentReference docRef = await _firestore.collection('employers').add(employerModel!.toJson());
    await docRef.update({'id': docRef.id});
  }

  Future getInformationEmployer(EmployerModel? employerModel) async {
    final jobPostings = await _firestore.collection('employers').get();

  }

}

