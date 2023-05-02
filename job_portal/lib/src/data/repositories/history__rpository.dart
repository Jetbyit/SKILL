import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/data/services/history_service.dart';

class HistoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  HistoryService _historyService = HistoryService();

  Future<void> addDataToFirebase({String? title,String? workdesc, String? hours, String? imageUrl, File? imageFile}) async {
    await  _historyService.addDataToFirebase(title: title, workdesc: workdesc, hours: hours,imageUrl: imageUrl, imageFile: imageFile);
  }
  Future<File?> compressImage(File imageFile) async {
    return await _historyService.compressImage(imageFile);
  }

}