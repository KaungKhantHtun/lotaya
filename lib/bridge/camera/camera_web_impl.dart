// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:hakathon_service/bridge/camera/camera_interface.dart';
import 'package:js/js.dart';

@JS('window.WaveJsSDK.mediaModule.openCamera')
external _openCamera();

class CameraBridgeImpl implements ICameraBridge {
  const CameraBridgeImpl();

  @override
  Future<String> openCamera() async {
    final result = _openCamera();
    final json = await promiseToFutureAsMap(result);
    final response = Map<String, dynamic>.from(json!['response']);
    return response['data'];
  }
}
