import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/visacard_model.dart';
import 'package:job_portal/src/data/models/workermodel.dart';

class JobPostingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadJobPosting(JobPosting jobPosting) async {
    // todo: firebase auth
    final user = FirebaseAuth.instance.currentUser;
    DocumentReference docRef = await _firestore.collection('job_postings').doc(user!.uid).collection('myjobs').add(jobPosting.toMap());
    DocumentReference docRefv1 = await _firestore.collection('job_postings_v1').add(jobPosting.toMap());
    await docRef.update({'id': docRef.id});
    await docRefv1.update({'id': docRef.id});
  }

  Future<List<JobPosting>> getJobPostings() async {
    final jobPostings = await _firestore.collection('job_postings_v1').get();
    return jobPostings.docs.map((doc) => JobPosting.fromSnapshot(doc)).toList();
  }

  Future<JobPosting> getJobItemPostings(String? jobId) async {
    final user = FirebaseAuth.instance.currentUser;
    final jobPostings = await _firestore.collection('job_postings').doc(user!.uid).collection('myjobs').doc(jobId).get();
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

  Future<void> updateInformationWorker(String userId, {String? location, String? bio, PaymentMethod? paymentMethod}) async {
    try {
      final workerRef = _firestore.collection('workers').doc(userId);

      // Update location if provided
      if (location != null) {
        await workerRef.update({'address': location});
        //worker?.address = location; // Update the worker object too
      }

      // Update bio if provided
      if (bio != null) {
        await workerRef.update({'bio': bio});
        //worker?.bio = bio; // Update the worker object too
      }

      // Update payment method if provided
      if (paymentMethod != null) {
        await workerRef.update({'paymentMethod': paymentMethod.toMap()});
        //worker?.paymentMethod = paymentMethod; // Update the worker object too
      }

      print('Worker information updated successfully');
    } catch (e) {
      print('Error updating worker information: $e');
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
    CollectionReference jobPostingsCollection = FirebaseFirestore.instance.collection('job_postings_v1');

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


  Future<QuerySnapshot<Map<String, dynamic>>> filterDataByParams({
    String? field,
    int? budget,
    String? location,
    DateTime? timestamp,
  }) async {
    CollectionReference<Map<String, dynamic>> dataCollection = FirebaseFirestore.instance.collection('job_postings');

    Query<Map<String, dynamic>> query = dataCollection;

    if (field != null) {
      query = query.where('field', isEqualTo: field);
    }

    if (budget != null) {
      query = query.where('budget', isEqualTo: budget);
    }

    if (location != null) {
      query = query.where('location', isEqualTo: location);
    }

    if (timestamp != null) {
      // Convert the DateTime to a Timestamp so it can be used in the query
      final startOfDay = DateTime(timestamp.year, timestamp.month, timestamp.day);
      final endOfDay = startOfDay.add(Duration(days: 1));
      final startTimestamp = Timestamp.fromDate(startOfDay);
      final endTimestamp = Timestamp.fromDate(endOfDay);

      query = query.where('timestamp', isGreaterThanOrEqualTo: startTimestamp).where('timestamp', isLessThan: endTimestamp);
    }

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
      return querySnapshot;
    } catch (e) {
      print('Error fetching filtered data: $e');
      rethrow;
    }
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
      'userId': userId,
    });
  }

  Future<bool> hasUserAppliedForJob({String? jobId, String? userId}) async {
    var jobApplyRef = FirebaseFirestore.instance.collection('job_applys').doc(jobId).collection('user_applys').doc(userId);
    var jobApplyDoc = await jobApplyRef.get();
    return jobApplyDoc.exists;
  }

  Future saveJobItem(String jobId) async {
    // todo: save item in  saved_items(collection) >> jobId(documents ids) >> users_saved(collection) >> usersIds(documents ids)
    // todo: save item in  saved_items(collection) >> usersIds(documents ids) >> jobe_saved(collection) >> jobId(documents ids) >>

    final user = FirebaseAuth.instance.currentUser;
    final savedItemsRef = FirebaseFirestore.instance.collection('saved_items').doc(user!.uid);
    await savedItemsRef.collection('jobe_saved').doc(jobId).set({"saved": true});
  }

  Future<bool> didUserSaveJob(String jobId) async {
    // Get the current user's authentication data
    final user = FirebaseAuth.instance.currentUser;
    // Get a reference to the "saved_items" collection in Firestore
    final savedItemsRef = FirebaseFirestore.instance.collection('saved_items').doc(user!.uid);
    // Check if the document for the current user's ID exists in the "users_saved" subcollection of the "saved_items" document
    final userSavedDoc = await savedItemsRef.collection('jobe_saved').doc(jobId).get();
    // If the document exists, return "true" indicating that the user has saved the job item. Otherwise, return "false".
    return userSavedDoc.exists;
  }

  Future<void> removeSavedJob(String jobId) async {
    // Get the current user's authentication data
    final user = FirebaseAuth.instance.currentUser;
    // Get a reference to the "saved_items" collection in Firestore
    final savedItemsRef = FirebaseFirestore.instance.collection('saved_items').doc(user!.uid);
    // Delete the document for the current user's ID in the "users_saved" subcollection of the "saved_items" document
    await savedItemsRef.collection('jobe_saved').doc(jobId).delete();
    // Check if there are any remaining user documents in the "users_saved" subcollection
    final remainingUserDocs = await savedItemsRef.collection('jobe_saved').get();
    // If there are no remaining user documents, delete the entire "saved_items" document
    if (remainingUserDocs.docs.isEmpty) {
      await savedItemsRef.delete();
    }
  }




}
