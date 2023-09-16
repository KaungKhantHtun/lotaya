class FreelancerEntity {
  final FreelancerType type;
  final String imgUrl;
  final String name;
  final int hourlyRate;
  final String location;
  final String bio;
  final int age;
  final String phoneNumber;

  FreelancerEntity({
    required this.type,
    required this.imgUrl,
    required this.name,
    required this.hourlyRate,
    required this.location,
    required this.bio,
    required this.age,
    required this.phoneNumber,
  });
  FreelancerEntity fromJson(Map<String, dynamic> json) {
    return FreelancerEntity(
      type: getType(json['type']),
      imgUrl: json['imgUrl'],
      name: json['name'],
      hourlyRate: int.tryParse(json['hourlyRate']) ?? 0,
      location: json['location'],
      bio: json['bio'],
      age: int.tryParse(json['age']) ?? 0,
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type.name;
    data['imgUrl'] = imgUrl;
    data['name'] = name;
    data['hourlyRate'] = hourlyRate;
    data['location'] = location;
    data['bio'] = bio;
    data['age'] = age;
    data['phoneNumber'] = phoneNumber;
    return data;
  }

 static FreelancerType getType(String type) {
    FreelancerType profession = FreelancerType.driver;
    switch (type) {
      case "Psychologist":
        profession = FreelancerType.psychologist;
        break;
      case "Driver":
        profession = FreelancerType.driver;
        break;
      case "Tutor":
        profession = FreelancerType.tutor;
        break;
      case "Baby Sitter":
        profession = FreelancerType.babySitter;
        break;

      case "Coach":
        profession = FreelancerType.coach;
        break;
      case "Nurse":
        profession = FreelancerType.nurse;
        break;
      case "Hair Stylist":
        profession = FreelancerType.hairStylist;
        break;
      case "Gardener":
      default:
        profession = FreelancerType.gardener;
        break;
    }
    return profession;
  }
}

enum FreelancerType {
  psychologist("Psychologist"),
  driver("Driver"),
  tutor("Tutor"),
  babySitter("Baby Sitter"),
  coach("Coach"),
  nurse("Nurse"),
  hairStylist("Hair Stylist"),
  gardener("Gardener");

  final String name;
  const FreelancerType(this.name);
}
