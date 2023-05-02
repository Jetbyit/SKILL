import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/visacard_model.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/data/services/job_offre_service.dart';

class JobOfferRepository {
  final JobPostingService _jobPostingService = JobPostingService();

  Future<void> creatInformationWorker(Worker? worker, String? userId) async{
    await _jobPostingService.creatInformationWorker(worker!, userId!);
  }

  Future<void> creatInformationEmployer(EmployerModel? employer, String userId) async{
    await _jobPostingService.creatInformationEmployer(employer!, userId);
  }

  Future<void> createJobPosting(JobPosting jobPosting) async {
    await _jobPostingService.uploadJobPosting(jobPosting);
  }

  Future<List<JobPosting>> getJobPostings() async {
    return await _jobPostingService.getJobPostings();
  }

  Future<JobPosting> getJobItemPostings(String? jobId) async {
    return await _jobPostingService.getJobItemPostings(jobId);
  }

  Future<EmployerModel> getInformationEmployer(String? userID) async {
    return await _jobPostingService.getInformationEmployer(userID!);
  }

  Future<Worker> getInformationWorkder(String? userID) async {
    return await _jobPostingService.getInformationWorker(userID!);
  }

  Future<List<JobPosting>> searchJobPostingsByDescription(String searchTerm) async {
    return await _jobPostingService.searchJobPostingsByDescription(searchTerm);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> filterDataByParams({
    String? field,
    int? budget,
    String? location,
    DateTime? timestamp,
  }) async {
    return await _jobPostingService.filterDataByParams(field: field, budget: budget, location: location, timestamp: timestamp,);
  }

  Future applyForJobOffer({
    String? jobId,
    String? userId,
    Worker? worker,
  }) async {
    return await _jobPostingService.applyForJobOffer(jobId: jobId, userId: userId, worker: worker);
  }


  Future<bool> hasUserAppliedForJob({String? jobId, String? userId}) async {
    return await _jobPostingService.hasUserAppliedForJob(jobId: jobId, userId: userId);
  }

  Future<void> updateInformationWorker(String? userId, {String? location, String? bio, PaymentMethod? paymentMethod}) async {
    await _jobPostingService.updateInformationWorker(userId!, location: location, bio: bio, paymentMethod: paymentMethod);
  }

  Future<void> saveJobItem(String jobId) async {
    await _jobPostingService.saveJobItem(jobId);
  }

  Future<bool> didUserSaveJob(String jobId) async {
    return await _jobPostingService.didUserSaveJob(jobId);
  }

  Future<void> removeSavedJob(String jobId) async {
    await _jobPostingService.removeSavedJob(jobId);
  }

}


