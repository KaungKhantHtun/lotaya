import 'package:hakathon_service/bridge/system/system_interface.dart';
import 'package:js/js.dart';

@JS('window.WaveJsSDK.viewModule.exit')
external _exist();

class SystemBridgeImpl implements ISystemBridge {
  const SystemBridgeImpl();

  @override
  Future<void> exist() async {
    _exist();
  }
}
