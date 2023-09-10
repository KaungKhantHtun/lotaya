import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/user_entity.dart';
import '../utils/constants.dart';

class UserProfileService {
  operateUserProfile() async {
    String? userId = await getUserId();
    if (userId == null) {
      UserEntity profile = await UserProfileService().getUserProfile();
      await UserProfileService().createProfile(profile);
    } else {}
  }

  Future<void> createProfile(UserEntity profile) async {
    final CollectionReference profileList =
        FirebaseFirestore.instance.collection(profileTable);
    try {
      await profileList.add(profile.toJson());
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
    return profile;
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }

  Future<void> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", userId);
  }
}
