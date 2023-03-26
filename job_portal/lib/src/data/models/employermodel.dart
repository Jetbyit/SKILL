import 'package:cloud_firestore/cloud_firestore.dart';

class EmployerModel {
  String _companyName;
  List<String> _skillsNeeded;
  String _jobLocation;
  String _additionalInfo;

  EmployerModel({
    required String companyName,
    required List<String> skillsNeeded,
    required String jobLocation,
    required String additionalInfo,
  })  : _companyName = companyName,
        _skillsNeeded = skillsNeeded,
        _jobLocation = jobLocation,
        _additionalInfo = additionalInfo;

  String get companyName => _companyName;
  List<String> get skillsNeeded => _skillsNeeded;
  String get jobLocation => _jobLocation;
  String get additionalInfo => _additionalInfo;

  set companyName(String companyName) {
    _companyName = companyName;
  }

  set skillsNeeded(List<String> skillsNeeded) {
    _skillsNeeded = skillsNeeded;
  }

  set jobLocation(String jobLocation) {
    _jobLocation = jobLocation;
  }

  set additionalInfo(String additionalInfo) {
    _additionalInfo = additionalInfo;
  }

  factory EmployerModel.fromJson(DocumentSnapshot json) {
    return EmployerModel(
      companyName: json['companyName'],
      skillsNeeded: List<String>.from(json['skillsNeeded']),
      jobLocation: json['jobLocation'],
      additionalInfo: json['additionalInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': _companyName,
      'skillsNeeded': _skillsNeeded,
      'jobLocation': _jobLocation,
      'additionalInfo': _additionalInfo,
    };
  }
}
