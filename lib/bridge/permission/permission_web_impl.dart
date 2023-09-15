import 'dart:html';

import 'package:hakathon_service/bridge/permission/permission_interface.dart';
import 'package:hakathon_service/bridge/system/system_interface.dart';
import 'package:js/js.dart';

@JS('window.WaveJsSDK.permissionModule.getPermissionList')
external _getPermissionList();

@JS('window.WaveJsSDK.permissionModule.getPermissionStatus')
external _getPermissionStatus(permissionName);

class PermissionBridgeImpl implements IPermissionBridge {
  const PermissionBridgeImpl();

  @override
  Future<List<String>> getPermissionList() async {
    final result = _getPermissionList();
    final json = await promiseToFutureAsMap(result);
    final response = Map<String, dynamic>.from(json!['response']);
    return response['data']['names'] as List<String>;
  }

  @override
  Future<bool> getPermissionStatus(String name) async {
    final result = _getPermissionStatus(name);
    final json = await promiseToFutureAsMap(result);
    final response = Map<String, dynamic>.from(json!['response']);
    return response['data']['granted'];
  }
}
