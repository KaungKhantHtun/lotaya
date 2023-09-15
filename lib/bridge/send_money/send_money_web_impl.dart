// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:js_util';

import 'package:hakathon_service/bridge/send_money/send_money_interface.dart';
import 'package:js/js.dart';

@JS('window.WaveJsSDK.paymentModule.makePayment')
external _makePayment(double amount, String receiver, String order);

class SendMoneyBridgeImpl implements ISendMoneyBridge {
  const SendMoneyBridgeImpl();

  @override
  Future<Payment> makePayment(
      double amount, String receiverMsisdn, String orderId) async {
    try {
      final result = _makePayment(amount, receiverMsisdn, orderId);
      final json = await promiseToFutureAsMap(result);
      final response = Map<String, dynamic>.from(json!['response']);
      return Payment.fromJson(response['data']);
    } catch (e) {
      final dartObj = dartify(e);
      if (dartObj != null) {
        final res = Map.from(dartObj as Map);
        return Future.error(res['response']['error']['code']);
      }

      return Future.error("Payment Failed");
    }
  }
}
