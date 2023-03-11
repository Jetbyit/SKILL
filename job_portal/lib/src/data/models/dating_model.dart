import 'package:flutter/material.dart';

class DatingAppModel {
  String? name;
  String? image;
  String? subTitle;
  String? subTitle1;
  bool? mISCheck;
  Widget? widget;
  Color? color;
  int?age;
  String? education;

  DatingAppModel({this.name, this.image, this.subTitle, this.subTitle1, this.mISCheck=false, this.widget, this.color,this.age,this.education});
}

class DAMessageModel {
  int? senderId;
  int? receiverId;
  String? msg;
  String? time;

  DAMessageModel({this.senderId, this.receiverId, this.msg, this.time});
}

List<DatingAppModel> getAllListData() {
  List<DatingAppModel> list = [];
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out',
      name: 'Eleanor Pena',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.9.jpg',
      age: 27,
      education: 'Bachelor of Arts'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Arlene McCoy',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.1.jpg',
      age: 25,
      education: 'Software Developer'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Jerome Bell',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.2.jpg',
      age: 28,
      education: 'B.Sc in Physiology'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Wade Warren',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.3.jpg',
      age: 23,
      education: 'Instrument Mechanic'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Darlene',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.4.jpg',
      age: 24,
      education: 'Stenography English'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Leslie Alexander',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.5.jpg',
      age: 26,
      education: 'Insurance Agent'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Jacob Jones',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.6.jpg',
      age: 21,
      education: 'Basic Cosmetology'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Wade Warren',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.7.jpg',
      age: 24,
      education: 'Marketing Executive'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Cameron',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.8.jpg',
      age: 22,
      education: 'Architectural Assistant'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Jacob Jones',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.10.jpg',
      age: 24,
      education: 'Software Developer'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out',
      name: 'Leslie Alexander',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.11.jpg',
      age: 22,
      education: 'B.Sc inin Physiology'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Darlene',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.12.jpg',
      age: 21,
      education: 'Instrument Mechanic'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Wade Warren',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.13.jpg',
      age: 25,
      education: 'Stenography English'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Jerome Bell',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.15.jpg',
      age: 24,
      education: 'Insurance Agent'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Wade Warren',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.16.jpg',
      age: 23,
      education: 'Basic Cosmetology'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Darlene',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.17.jpg',
      age: 25,
      education: 'Marketing Executive'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Leslie Alexander',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.18.jpg',
      age: 26,
      education: 'Architectural Assistant'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Jacob Jones',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.19.jpg',
      age: 26,
      education: 'Bachelor of Arts'));
  list.add(DatingAppModel(
      subTitle1: 'Was great hanging out!',
      name: 'Wade Warren',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.20.jpg',
      age: 22,
      education: 'Insurance Agent'));
  list.add(DatingAppModel(
      subTitle1: 'Wade Warren',
      name: 'Cameron',
      subTitle: 'Student',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.21.jpg',
      age: 24,
      education: 'Basic Cosmetology'));
  list.add(DatingAppModel(
      name: 'Ayush Mehra ',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.22.jpg',
      subTitle1: 'Was great hanging out!',
      subTitle: 'Student',
      age: 22,
      education: 'Marketing Executive'));
  list.add(DatingAppModel(
      name: 'Barkha Singh',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.23.jpg',
      subTitle1: 'Wade Warren',
      subTitle: 'Student',
      age: 26,
      education: 'Architectural Assistant'));
  list.add(DatingAppModel(
      name: 'Barkha Singh',
      image: 'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.24.jpg',
      subTitle1: 'Wade Warren',
      subTitle: 'Student',
      age: 23,
      education: 'Basic Cosmetology'));

  return list;
}

