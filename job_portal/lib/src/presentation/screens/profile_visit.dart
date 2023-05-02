import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_portal/src/data/models/dating_model.dart';
import 'package:job_portal/src/data/models/previos_work.dart';
import 'package:job_portal/src/data/models/user_data.dart';
import 'package:job_portal/src/data/models/workermodel.dart';
import 'package:job_portal/src/data/repositories/job_offer_repository.dart';
import 'package:job_portal/src/presentation/screens/edit_worker_screen.dart';
import 'package:job_portal/src/presentation/widgets/common_cached_image.dart';
import 'package:job_portal/src/presentation/widgets/sidebar_user.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AProfileVisiting extends StatefulWidget {
  final String? peeruserId;
  AProfileVisiting({this.peeruserId});
  @override
  AProfileVisitingState createState() => AProfileVisitingState();
}

class AProfileVisitingState extends State<AProfileVisiting> {
  List<PreviosWorkImages> list = getAllListDataSkill();
  JobOfferRepository _jobOfferRepository = JobOfferRepository();
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    var currentUserId = Provider.of<UserData>(context, listen: false).currentUserId;
    //String? currentUserId = "ysisE24TaEXyimVfzPSrZfkB5mP2";
    try {
      final ref = FirebaseStorage.instance.ref().child('avatars/${DateTime.now()}.png');
      await ref.putFile(_image!);
      final url = await ref.getDownloadURL();
      print('image url is : $url');
      await FirebaseFirestore.instance
          .collection('workers')
          .doc(currentUserId)
          .update({'imageUrl': url});
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<List<DocumentSnapshot>> _workFuture() async {
    //final user = _auth.currentUser;
    if (widget!.peeruserId! == null) return [];

    final querySnapshot = await FirebaseFirestore.instance
        .collection('myCollection')
        .doc(widget!.peeruserId!)
        .collection('mywork')
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    list.shuffle();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: jobportalBrownColor),
        ),
        backgroundColor: Colors.white, //jobportalBrownColor
        elevation: 0,

        //centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //Sidebar(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sidebar(),
                  ));
            },
            icon: const Icon(
              Icons.settings,
              color: jobportalBrownColor,
            ),
          ),
        ],
        leading: const Icon(
          Icons.person,
          color: jobportalBrownColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                FutureBuilder<Worker>(
                  future: _jobOfferRepository.getInformationWorkder(widget!.peeruserId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final workerModel = snapshot.data;
                      return Column(
                        children: [
                          CircleAvatar(
                              radius: 50.0,
                              backgroundImage: _image != null ? FileImage(_image!) : null,

                              child: workerModel!.imageUrl! == null ?
                              const Icon(
                                Icons.person,
                                size: 50.0,
                              ) : CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.grey[300],
                                child: ClipOval(
                                  child: Image.network(
                                    workerModel!.imageUrl!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )


                          ),
                          SizedBox(height: 4),
                          TextButton(
                            onPressed: _getImage,
                            child: Text('Select Image'),
                          ),
                          SizedBox(height: 8),
                          // _isLoading
                          //     ? CircularProgressIndicator()
                          //     : TextButton(
                          //   onPressed: _image != null ? _uploadImage : null,
                          //   child: Text('Upload Image'),
                          // ),
                          16.height,
                          Text('Worker Name: ${workerModel!.name}',
                              style: boldTextStyle()),
                          16.height,
                          Text(
                            '${workerModel!.address}',
                            style: secondaryTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          16.height,
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                AppButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.wifi_tethering_rounded, color: jobportalBrownColor),
                      Text(
                        'Upgrade your profile',
                        style: boldTextStyle(color: jobportalBrownColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(),
                    ],
                  ),
                  width: context.width(),
                  color: iconColorPrimary,
                  onTap: () {
                    //DASettingScreen().launch(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            16.height,

            FutureBuilder<Worker>(
              future: _jobOfferRepository.getInformationWorkder(widget!.peeruserId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Worker? workerModel = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bio', style: boldTextStyle(size: 25)),
                      16.height,
                      Text(
                        "${workerModel!.bio}",
                        style: secondaryTextStyle(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      16.height,
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Skill', style: boldTextStyle(size: 25)),
                Text('Add skill',
                    style: primaryTextStyle(color: jobportalBrownColor))
                    .onTap(
                      () {
                    //DAProfileViewAllScreen().launch(context);
                    print("DAProfileViewAllScreen().launch(context);");
                  },
                ),
              ],
            ),

            FutureBuilder<Worker>(
              future: _jobOfferRepository
                  .getInformationWorkder(widget!.peeruserId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final workerModel = snapshot.data;
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      shrinkWrap: true,
                      itemCount: workerModel!.skills.length,
                      itemBuilder: (context, index) {
                        Color color =
                        Colors.primaries[index % Colors.primaries.length];
                        return Chip(
                          label: Text('${workerModel!.skills[index]}',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: color,
                          deleteIcon: Icon(Icons.cancel, color: Colors.white),
                          onDeleted: () {
                            // Do something when the cancel button is pressed
                          },
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Previous work', style: boldTextStyle()),
                Text('View All',
                    style: primaryTextStyle(color: jobportalBrownColor))
                    .onTap(
                      () {
                    //DAProfileViewAllScreen().launch(context);
                    print("DAProfileViewAllScreen().launch(context);");
                  },
                ),
              ],
            ),
            16.height,
            FutureBuilder(
              future: _workFuture(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        //Color color = Colors.primaries[index % Colors.primaries.length];
                        final work = snapshot.data![index].data();
                        return CommonCachedNetworkImage(
                          imageUrl: work['image'],
                          fit: BoxFit.cover,
                          height: 100,
                          width: (context.width() / 3) - 22,
                        ).cornerRadiusWithClipRRect(10).onTap(() {
                          print(
                              "DAZoomingScreen(img: e.image).launch(context);");
                        }, highlightColor: white, splashColor: white);
                      });
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            // Wrap(
            //   runSpacing: 16,
            //   spacing: 16,
            //   children: list.take(12).map(
            //     (e) {
            //       return CommonCachedNetworkImage(
            //         imageUrl: e.imageUrl,
            //         fit: BoxFit.cover,
            //         height: 100,
            //         width: (context.width() / 3) - 22,
            //       ).cornerRadiusWithClipRRect(10).onTap(() {
            //         print("DAZoomingScreen(img: e.image).launch(context);");
            //       }, highlightColor: white, splashColor: white);
            //     },
            //   ).toList(),
            // ),
          ],
        ).paddingOnly(left: 16, right: 16, bottom: 16),
      ),
    );
  }
}