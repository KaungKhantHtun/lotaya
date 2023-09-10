class UserEntity {
  final String name;
  final String? nrc;
  final String msisdn;
  final String? gender;
  final String kycStatus;
  final String? dob;

  UserEntity(
      {required this.name,
      this.nrc,
      required this.msisdn,
      this.gender,
      required this.kycStatus,
      this.dob});
  Map<String, dynamic> toJson() {
    return {
      "dob": dob, // "1999-04-28"
      "name": name,
      "nrc": nrc,
      "msisdn": msisdn,
      "gender": gender, // "Male", "Female"
      "kyc_status": kycStatus
    };
  }

  static UserEntity fromJson(Map<String, dynamic> map) {
    return UserEntity(
        dob: map["dob"], // "1999-04-28"
        name: map["name"],
        nrc: map["nrc"],
        msisdn: map["msisdn"],
        gender: map["gender"], // "Male", "Female"
        kycStatus: map["kyc_status"]);
  }
}
