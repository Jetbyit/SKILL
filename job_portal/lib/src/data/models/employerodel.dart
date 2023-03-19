class EmployerModel {
  final String companyName;
  final List<String> skillsNeeded;
  final String jobLocation;
  final String additionalInfo;

  EmployerModel({
    required this.companyName,
    required this.skillsNeeded,
    required this.jobLocation,
    required this.additionalInfo,
  });

  factory EmployerModel.fromJson(Map<String, dynamic> json) {
    return EmployerModel(
      companyName: json['companyName'],
      skillsNeeded: List<String>.from(json['skillsNeeded']),
      jobLocation: json['jobLocation'],
      additionalInfo: json['additionalInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'skillsNeeded': skillsNeeded,
      'jobLocation': jobLocation,
      'additionalInfo': additionalInfo,
    };
  }
}
