library bridge;

export '././user_info/user_info_interface.dart';
export './native_bridge_channel.dart';
export '././user_info/user_info_mobile_impl.dart'
    if (dart.library.html) 'package:bridge/src/user_info_web_impl.dart';
