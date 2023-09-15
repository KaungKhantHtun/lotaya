// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:hakathon_service/bridge/location/location_interface.dart';
import 'package:js/js.dart';

@JS('window.WaveJsSDK.locationModule.getCurrentPosition')
external _getCurrentLocation();

class LocationBridgeImpl implements ILocationBridge {
  const LocationBridgeImpl();

  @override
  Future<Location> getCurrentLocation() async {
    final result = _getCurrentLocation();
    final json = await promiseToFutureAsMap(result);
    final response = Map<String, dynamic>.from(json!['response']);
    return Location.fromJson(response['data']);
  }

  // @override
  // Future<UserInfo> getUserInfo() async {
  //   final result = _getUserInfo();
  //   final json = await promiseToFutureAsMap(result);
  //   final response = Map<String, dynamic>.from(json!['response']);
  //   return UserInfo.fromJson(response['data']);
  // }
}
