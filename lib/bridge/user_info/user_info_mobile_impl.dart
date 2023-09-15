// import '../native_bridge_channel.dart';
// import './user_info_interface.dart';

// class UserInfoBridgeImpl implements IUserInfoBridge {
//   UserInfoBridgeImpl();

//   @override
//   Future<UserInfo> getUserInfo() async {
//     final result = await NativeBridgeChannel.instance.postMessage(
//       RequestPayload(
//         handlerFunction: '_getUserInformation',
//         reqTnxID: DateTime.now().microsecondsSinceEpoch.toString(),
//         handlerType: HandlerType.function.name,
//       ),
//     );
//     return UserInfo.fromJson(result.data!);
//   }
// }
