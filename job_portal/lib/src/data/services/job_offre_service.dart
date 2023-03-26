import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/workermodel.dart';

class JobPostingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadJobPosting(JobPosting jobPosting) async {
    DocumentReference docRef =
        await _firestore.collection('job_postings').add(jobPosting.toMap());
    await docRef.update({'id': docRef.id});
  }

  Future<List<JobPosting>> getJobPostings() async {
    final jobPostings = await _firestore.collection('job_postings').get();
    return jobPostings.docs.map((doc) => JobPosting.fromSnapshot(doc)).toList();
  }

  Future<JobPosting> getJobItemPostings(String? jobId) async {
    final jobPostings =
        await _firestore.collection('job_postings').doc(jobId).get();
    return JobPosting.fromSnapshot(jobPostings);
    //return jobPostings.docs.map((doc) => JobPosting.fromSnapshot(doc)).toList();
  }

  Future<void> creatInformationWorker(Worker? worker, String userId) async {
    //DocumentReference docRef = await _firestore.collection('workers').add(worker!.toJson());
    //await docRef.update({'id': docRef.id});

    try {
      await _firestore.collection('workers').doc(userId).set(worker!.toJson());
    } catch (e) {
      print("err when try to add worker information is : ${e}");
    }
  }

  Future getInformationWorker(String? userID) async {
    DocumentSnapshot? jobPostings =
        await _firestore.collection('workers').doc(userID).get();
    return Worker.fromJson(jobPostings);
  }

  Future<void> creatInformationEmployer(
      EmployerModel? employerModel, String userId) async {
    try {
      await _firestore
          .collection('employers')
          .doc(userId)
          .set(employerModel!.toJson());
    } catch (e) {
      print("err when try to add employer information is : ${e}");
    }

    ///await docRef.update({'id': docRef.id});
  }

  Future<EmployerModel> getInformationEmployer(String? userID) async {
    DocumentSnapshot? jobPostings =
        await _firestore.collection('employers').doc(userID).get();
    return EmployerModel.fromJson(jobPostings);
  }

  Future<List<JobPosting>> searchJobPostingsByDescription(String searchTerm) async {
    // Get a reference to the job postings collection in the database
    CollectionReference jobPostingsCollection = FirebaseFirestore.instance.collection('job_postings');

    // Query the job postings collection for documents whose description field contains the search term
    String searchTermEdit = searchTerm.substring(0, 1).toUpperCase() + searchTerm.substring(1).toLowerCase();

    QuerySnapshot jobPostingsSnapshot = await jobPostingsCollection
        .where('field', isGreaterThanOrEqualTo: searchTermEdit)
        .get();

    // Convert the query snapshot into a list of JobPosting objects
    List<JobPosting> jobPostings = jobPostingsSnapshot.docs
        .map((doc) => JobPosting.fromSnapshot(doc))
        .toList();

    // Sort the job postings list by timestamp in descending order (newest first)
    jobPostings.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return jobPostings;
  }

  Future applyForJobOffer({
    String? jobId,
    String? userId,
    Worker? worker,
  }) async {
    // Get a reference to the Firestore collection where job applications are stored
    final jobApplysRef = FirebaseFirestore.instance.collection('job_applys');

    // Create a new document for this job application
    final jobDocRef = jobApplysRef.doc(jobId);

    // Get a reference to the Firestore collection where user applications are stored
    final userApplysRef = jobDocRef.collection('user_applys');

    // Create a new document for this user's application
    final userDocRef = userApplysRef.doc(userId);

    // Save information about the user's application in the Firestore document
    await userDocRef.set({
      'skills': worker!.skills,
      'address': worker!.address,
      'previousWorkExperience': worker!.previousWorkExperience,
      'date': FieldValue.serverTimestamp(),
    });
  }

  Future<bool> hasUserAppliedForJob({String? jobId, String? userId}) async {
    var jobApplyRef = FirebaseFirestore.instance.collection('job_applys').doc(jobId).collection('user_applys').doc(userId);
    var jobApplyDoc = await jobApplyRef.get();
    return jobApplyDoc.exists;
  }

}
