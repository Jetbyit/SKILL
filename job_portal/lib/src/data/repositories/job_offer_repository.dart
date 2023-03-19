import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/data/services/job_offre_service.dart';

class JobOfferRepository {
  final JobPostingService _jobPostingService = JobPostingService();

  Future<void> creatInformationWorker(Worker? worker) async{
    await _jobPostingService.creatInformationWorkder(worker!);
  }

  Future<void> creatInformationEmployer(EmployerModel? employer) async{
    await _jobPostingService.creatInformationEmployer(employer!);
  }

  Future<void> createJobPosting(JobPosting jobPosting) async {
    await _jobPostingService.uploadJobPosting(jobPosting);
  }

  Future<List<JobPosting>> getJobPostings() async {
    return await _jobPostingService.getJobPostings();
  }
}


