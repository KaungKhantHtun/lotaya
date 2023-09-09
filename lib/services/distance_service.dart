import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakathon_service/utils/constants.dart';

class CalculateDistance {
  Future<DistanceAndDuration> calculateEstimateDistance(
      LatLng start, LatLng current) async {
    Response response = await Dio().get(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=matric&origins=${start.latitude},${start.longitude}&destinations=${current.latitude},${current.longitude}&key=$mapApiKey");
    print(response.data);
    return DistanceAndDuration.fromJson(
        response.data["rows"][0]["elements"][0]);
  }
}

class DistanceAndDuration {
  Distance distance;
  Distance duration;
  String status;

  DistanceAndDuration({
    required this.distance,
    required this.duration,
    required this.status,
  });

  factory DistanceAndDuration.fromJson(Map<String, dynamic> json) =>
      DistanceAndDuration(
        distance: Distance.fromJson(json["distance"]),
        duration: Distance.fromJson(json["duration"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "status": status,
      };
}

class Distance {
  String text;
  int value;

  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
      };
}
