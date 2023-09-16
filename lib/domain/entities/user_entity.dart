import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String userId;
  final String name;
  final String? nrc;
  final String msisdn;
  final String? gender;
  final String kycStatus;
  final String? dob;
  final String? email;
  final String? phno;
  final String? field;
  final int? priceRate;
  final String? location;
  final String? description;

  UserEntity({
    required this.userId,
    required this.name,
    this.nrc,
    required this.msisdn,
    this.gender,
    required this.kycStatus,
    this.dob,
    this.email,
    this.phno,
    this.field,
    this.priceRate,
    this.location,
    this.description,
  });
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "dob": dob, // "1999-04-28"
      "name": name,
      "nrc": nrc,
      "msisdn": msisdn,
      "gender": gender, // "Male", "Female"
      "kyc_status": kycStatus,
      "email": email,
      "phno": phno,
      "field": field,
      "priceRate": priceRate,
      "location": location,
      "description": description,
    };
  }

  static UserEntity fromJson(Map<String, dynamic>? map) {
    return UserEntity(
      userId: map?["userId"],
      dob: map?["dob"], // "1999-04-28"
      name: map?["name"],
      nrc: map?["nrc"],
      msisdn: map?["msisdn"],
      gender: map?["gender"], // "Male", "Female"
      kycStatus: map?["kyc_status"],
      email: map?["email"],
      phno: map?["phno"],
      field: map?["field"],
      priceRate: map?["priceRate"],
      location: map?["location"],
      description: map?["description"],
    );
  }
  // static BookingEntity fromDoc(QueryDocumentSnapshot<Object?>? doc) {
  //   return BookingEntity(
  //     bookingId: doc?.data().toString().contains("bookingId") ?? false
  //         ? doc?.get("bookingId")
  //         : "",

  static UserEntity fromDoc(DocumentSnapshot<Map<String, dynamic>>? doc) {
    return UserEntity(
      userId: doc?.data().toString().contains("userId") ?? false
          ? doc?.get("userId")
          : "",
      name: doc?.data().toString().contains("name") ?? false
          ? doc?.get("name")
          : "",
      msisdn: doc?.data().toString().contains("msisdn") ?? false
          ? doc?.get("msisdn")
          : "",
      kycStatus: doc?.data().toString().contains("kycStatus") ?? false
          ? doc?.get("kycStatus")
          : "",
      dob: doc?.data().toString().contains("dob") ?? false
          ? doc?.get("dob")
          : "",
      gender: doc?.data().toString().contains("gender") ?? false
          ? doc?.get("gender")
          : "",
      nrc: doc?.data().toString().contains("nrc") ?? false
          ? doc?.get("nrc")
          : "",
      email: doc?.data().toString().contains("email") ?? false
          ? doc?.get("email")
          : "",
      phno: doc?.data().toString().contains("phno") ?? false
          ? doc?.get("phno")
          : "",
      field: doc?.data().toString().contains("field") ?? false
          ? doc?.get("field")
          : "",
      priceRate: doc?.data().toString().contains("priceRate") ?? false
          ? int.tryParse(doc?.get("priceRate").toString() ?? "") ?? 0
          : 0,
      location: doc?.data().toString().contains("location") ?? false
          ? doc?.get("location")
          : "",
      description: doc?.data().toString().contains("description") ?? false
          ? doc?.get("description")
          : "",
    );
  }
}
