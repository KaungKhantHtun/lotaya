// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:js/js.dart';

import './user_info_interface.dart';

@JS('window.WaveJsSDK.userModule.getUserInformation')
external _getUserInfo();

@JS('window.WaveJsSDK.userModule.getUserLoginStatus')
external _userLoginStatus();

class UserInfoBridgeImpl implements IUserInfoBridge {
  const UserInfoBridgeImpl();

  @override
  Future<UserInfo> getUserInfo() async {
    final result = _getUserInfo();
    final json = await promiseToFutureAsMap(result);
    final response = Map<String, dynamic>.from(json!['response']);
    return UserInfo.fromJson(response['data']);
  }

  @override
  Future<bool> userLoginStatus() async {
    final result = _userLoginStatus();
    final json = await promiseToFutureAsMap(result);
    final response = Map<String, dynamic>.from(json!['response']);
    return response['data']['is_logged_in'];
  }
}
