abstract class IUserInfoBridge {
  Future<UserInfo> getUserInfo();
}

class UserInfo {
  String? dob;
  String name;
  String? nrc;
  String msisdn;
  String? gender;
  String kycStatus;

  UserInfo({
    required this.dob,
    required this.name,
    required this.nrc,
    required this.msisdn,
    required this.gender,
    required this.kycStatus,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        dob: json["dob"],
        name: json["name"],
        nrc: json["nrc"],
        msisdn: json["msisdn"],
        gender: json["gender"],
        kycStatus: json["kyc_status"],
      );

  Map<String, dynamic> toJson() => {
        "dob": dob,
        "name": name,
        "nrc": nrc,
        "msisdn": msisdn,
        "gender": gender,
        "kyc_status": kycStatus,
      };
}
