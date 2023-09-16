import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/bridge/location/location_interface.dart';
import 'package:hakathon_service/bridge/location/location_web_impl.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:map_picker/map_picker.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  final ILocationBridge _iLocationBridge = Get.put(const LocationBridgeImpl());

  LatLng _latLng = LatLng(16.8409, 96.1735);

  late CameraPosition cameraPosition;

  var textController = TextEditingController();

  getAddress() async {
    final api = GoogleGeocodingApi(mapApiKey, isLogged: kDebugMode);
    final reversedSearchResults = await api.reverse(
      '${cameraPosition.target.latitude},${cameraPosition.target.longitude}',
      language: 'en',
    );

    // update the ui with the address
    textController.text =
        '${reversedSearchResults.results.first.formattedAddress.characters}';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation();
  }

  getLocation() async {
    Location location = await _iLocationBridge.getCurrentLocation();
    cameraPosition = CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: 14.4746,
    );

    getAddress();
    Future.delayed(Duration(seconds: 0)).then(
      (value) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: Image.asset(
              "assets/pin.png",
              height: 40,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              // hide location button
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              //  camera position
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
                textController.text = "checking ...";
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                print("mapFinishedMoving");
                // notify map stopped moving
                mapPickerController.mapFinishedMoving!();
                //get address name from camera position
                await getAddress();
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 50,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextFormField(
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero, border: InputBorder.none),
                controller: textController,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 50,
              child: TextButton(
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFFFFFFF),
                    fontSize: 19,
                    // height: 19/19,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    [
                      textController.text,
                      cameraPosition.target,
                    ],
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(colorPrimary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
