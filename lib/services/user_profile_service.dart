import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../bridge/user_info/user_info_interface.dart';
import '../bridge/user_info/user_info_web_impl.dart';
import '../utils/constants.dart';

class UserProfileService {
  static String? msisdn;
  operateUserProfile() async {
    UserInfo userInfo = await getUserProfile();
    msisdn = userInfo.msisdn;
    bool isNewUser = await checkMsisdn(userInfo.msisdn);
    if (isNewUser) {
      await UserProfileService().createProfile(userInfo);
    } else {}
  }

  Future<void> createProfile(UserInfo userInfo) async {
    final CollectionReference profileList =
        FirebaseFirestore.instance.collection(profileTable);
    try {
      await profileList.doc(userInfo.msisdn).set(userInfo.toJson());
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  Future<UserInfo> getUserProfile() async {
    final IUserInfoBridge _iUserInfoBridge =
        Get.put(const UserInfoBridgeImpl());

    return await _iUserInfoBridge.getUserInfo();
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
    return snapshot.data() == null;
  }
}
