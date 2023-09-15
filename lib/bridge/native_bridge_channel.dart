import 'dart:convert';

import 'package:flutter/services.dart';

typedef OnDataReceivedCallBack = void Function(ResponseData);

enum HandlerType { function, observable }

class ResponseData {
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? error;
  ResponseData({this.data, this.error});

  factory ResponseData.fromMap(Map<String, dynamic> map) {
    final response = Map<String, dynamic>.from(map['response']);
    return ResponseData(
      data: response['data'],
      error: response['error'],
    );
  }

  Map<String, dynamic> toMap() => {
        "response": {
          "data": data,
          "error": error,
        }
      };

  @override
  String toString() {
    return jsonEncode({...data ?? {}, ...error ?? {}});
  }
}

class RequestPayload {
  final String reqTnxID;
  final String handlerFunction;
  final String handlerType;
  final String? clientID;
  final Map<String, dynamic>? data;

  RequestPayload({
    required this.reqTnxID,
    required this.handlerFunction,
    required this.handlerType,
    this.clientID,
    this.data,
  });

  factory RequestPayload.fromMap(Map<String, dynamic> map) {
    final request = Map<String, dynamic>.from(map['request']);

    return RequestPayload(
      reqTnxID: request['requestTransactionId'],
      handlerFunction: "request['handlerFunction']",
      handlerType: request['handlerType'],
      clientID: request['clientId'],
      data: request['data'],
    );
  }

  Map<String, dynamic> toMap() => {
        "request": {
          "requestTransactionId": reqTnxID,
          "handlerFunction": handlerFunction,
          "handlerType": handlerType,
          "clientId": clientID,
          "data": data,
        }
      };
}

class NativeBridgeChannel {
  static final instance = NativeBridgeChannel._();
  NativeBridgeChannel._() {
    methodChannel.setMethodCallHandler((call) async {
      _listeners[call.method]
          ?.call(ResponseData.fromMap(jsonDecode(call.arguments.toString())));
    });
  }
  factory NativeBridgeChannel() => instance;
  final methodChannel = const MethodChannel('flutter_module_channel');

  final _listeners = <String, OnDataReceivedCallBack>{};

  void subscribe(String eventName, OnDataReceivedCallBack onDataReceived) {
    _listeners[eventName] = onDataReceived;
    postMessage(
      RequestPayload(
        reqTnxID: 'reqTnxID',
        handlerFunction: eventName,
        handlerType: 'observable',
        data: {
          "name": "on",
        },
      ),
    );
  }

  void unsubscribe(String eventName) {
    _listeners.remove(eventName);
    postMessage(
      RequestPayload(
        reqTnxID: DateTime.now().millisecondsSinceEpoch.toString(),
        handlerFunction: eventName,
        handlerType: 'observable',
        data: {
          "name": "off",
        },
      ),
    );
  }

  Future<ResponseData> postMessage(RequestPayload payload) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'handler',
        jsonEncode(payload.toMap()),
      );
      if (result != null) {
        return ResponseData.fromMap(jsonDecode(result));
      }
      throw UnimplementedError();
    } catch (e) {
      return ResponseData(
        error: {
          "code": "WM-OTHER-001",
          "message": "Unknown Error Occurred $e",
        },
      );
    }
  }
}
