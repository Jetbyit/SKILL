class Worker {
  String id;
  String name;
  String previousWorkExperience;
  String address;
  List<String> skills;

  Worker({
    required this.id,
    required this.name,
    required this.previousWorkExperience,
    required this.address,
    required this.skills,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      previousWorkExperience: json['previousWorkExperience'],
      skills: List<String>.from(json['skills']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      "previousWorkExperience": previousWorkExperience,
      'skills': skills,
    };
  }
}
