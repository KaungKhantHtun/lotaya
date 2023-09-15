abstract class IPermissionBridge {
  Future<List<String>> getPermissionList();
  Future<bool> getPermissionStatus(String name);
}
