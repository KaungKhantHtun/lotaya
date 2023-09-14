import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:hakathon_service/utils/constants.dart';

class MapRoutService {
  setUp() {
    GoogleMapsDirections.init(googleAPIKey: mapApiKey);
  }

  Future<double> calculateDistance(LatLng start, LatLng current) async {
    DistanceValue distanceBetween = await distance(
      start.latitude,
      start.longitude,
      current.latitude,
      current.longitude,
      googleAPIKey: mapApiKey,
    );

    int distanceInMeters = distanceBetween.meters;
    double distanceInKiloMeters = distanceInMeters / 1000;
    double roundDistanceInKM =
        double.parse((distanceInKiloMeters).toStringAsFixed(2));
    print("@>textInKmOrMeters: $roundDistanceInKM");
    return roundDistanceInKM;
  }

  Future<String> calculateEsimateTime(LatLng start, LatLng current) async {
    DurationValue durationBetween = await duration(
      start.latitude,
      start.longitude,
      current.latitude,
      current.longitude,
      googleAPIKey: mapApiKey,
    );

    String durationInMinutesOrHours = durationBetween.text;
    print("@>durationInMinutesOrHours: $durationInMinutesOrHours");
    return durationInMinutesOrHours;
  }
}

class RouteDirectionMap extends StatefulWidget {
  const RouteDirectionMap({super.key, required this.from, required this.to});

  final LatLng from;
  final LatLng to;

  @override
  State<RouteDirectionMap> createState() => _RouteDirectionMapState();
}

class _RouteDirectionMapState extends State<RouteDirectionMap> {
  late Directions directions;
  late DirectionRoute route;
  final MapsRoutes route2 = MapsRoutes();
  List<Polyline> polylines = [];
  @override
  void initState() {
    GoogleMapsDirections.init(googleAPIKey: mapApiKey);
    getDirection(widget.from, widget.to);
  }

  getDirection(LatLng from, LatLng to) async {
    directions = await getDirections(
      from.latitude,
      from.longitude,
      to.latitude,
      to.longitude,
    );

    route = directions.shortestRoute;

    List<LatLng> points = PolylinePoints()
        .decodePolyline(route.overviewPolyline.points)
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();

    await route2.drawRoute(points, "avc", Colors.red, mapApiKey,
        travelMode: TravelModes.walking);

    // polylines = [
    //   Polyline(
    //     width: 5,
    //     polylineId: PolylineId(
    //         "${from.latitude}-${from.longitude}_${to.latitude}-${to.longitude}"),
    //     color: Colors.red,
    //     points: points,
    //   ),
    // ];
    setState(() {});
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return GoogleMapsWidget(
      apiKey: mapApiKey,
      sourceLatLng: LatLng(40.484000837597925, -3.369978368282318),
      destinationLatLng: LatLng(40.48017307700204, -3.3618026599287987),
      routeWidth: 4,
      routeColor: Colors.red,
      // GoogleMap(
      //   mapType: MapType.normal,
      //   polylines: route2.routes, //Set.of(polylines),
      //   initialCameraPosition: CameraPosition(
      //     target: widget.from,
      //     zoom: 16.4746,
      //   ),
      // onMapCreated: (GoogleMapController controller) {
      //   _controller.complete(controller);
      // },
    );
  }
}
