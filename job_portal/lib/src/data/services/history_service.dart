import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/employermodel.dart';
import 'package:job_portal/src/data/models/history_model.dart';
import 'package:job_portal/src/data/models/job_offer.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> addDataToFirebase(
      {String? title,
      String? workdesc,
      String? hours,
      String? imageUrl,
      File? imageFile}) async {
    try {
      // Upload image to Firebase Storage
      // Compress image before uploading
      final compressedImageFile = await compressImage(imageFile!);
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(compressedImageFile!);
      final TaskSnapshot downloadUrl =
          (await uploadTask.whenComplete(() => null));
      final String url = (await downloadUrl.ref.getDownloadURL());

      // Add data to Firebase Firestore

      await FirebaseFirestore.instance
          .collection('myCollection')
          .doc(_auth.currentUser!.uid)
          .collection('mywork')
          .add({
        'name': title,
        'hours': hours,
        'date': FieldValue.serverTimestamp(),
        'image': url,
        'worddesc': workdesc,
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('myCollection')
            .doc(_auth.currentUser!.uid)
            .collection('mywork')
            .doc(value.id)
            .update({
          'id': value.id,
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Future<File?> compressImage(File imageFile) async {
    final filePath = imageFile.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_compressed.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 50,
    );

    return result;
  }

  Future getDataAboutWorker(String userId, String docId) async {
    var data = await FirebaseFirestore.instance
        .collection('myCollection')
        .doc(_auth.currentUser!.uid)
        .collection('mywork')
        .doc(docId)
        .get();
    return await data;
  }
}
