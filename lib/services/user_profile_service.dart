import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/entities/user_entity.dart';
import '../utils/constants.dart';

class UserProfileService {
  static late String msisdn;
  operateUserProfile() async {
    UserEntity userEntity = await getUserProfile();
    bool isNewUser = await checkMsisdn(userEntity.msisdn);
    if (isNewUser) {
      await UserProfileService().createProfile(userEntity);
    } else {}
  }

  Future<void> createProfile(UserEntity profile) async {
    final CollectionReference profileList =
        FirebaseFirestore.instance.collection(profileTable);
    try {
      await profileList.doc(profile.msisdn).set(profile.toJson());
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  Future<UserEntity> getUserProfile() async {
    //TODO get user from SDK
    UserEntity profile = UserEntity(
      userId: "4566",
      kycStatus: "LEVEL 2",
      msisdn: "09401531039",
      name: "Ei Zin Htun",
      dob: "24.4.1996",
      gender: "Female",
      nrc: "8/HTALANA(N)123456",
    );
    msisdn = profile.msisdn;
    return profile;
  }

  Future<bool> checkMsisdn(String msisdn) async {
    final CollectionReference profileList =
        FirebaseFirestore.instance.collection(profileTable);
    late DocumentSnapshot<Object?> snapshot;
    try {
      snapshot = await profileList.doc(msisdn).get();
    } catch (e) {
      print('Error retrieving data: $e');
    }
    return snapshot == null;
  }
}
