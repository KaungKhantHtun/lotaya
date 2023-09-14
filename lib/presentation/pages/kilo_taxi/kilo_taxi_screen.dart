import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakathon_service/services/distance_service.dart';
import 'package:hakathon_service/services/location_service.dart';
import 'package:hakathon_service/utils/constants.dart';
// import 'package:intl/intl.dart';

class KiloTaxiScreen extends StatefulWidget {
  const KiloTaxiScreen({super.key});

  @override
  State<KiloTaxiScreen> createState() => _KiloTaxiScreenState();
}

class _KiloTaxiScreenState extends State<KiloTaxiScreen> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  LatLng? _fromLatLng;
  LatLng? _toLatLng;

  int selectedDevice = 1;
  int selectdType = 0;
  int selectedDay = 0;
  int selectedTime = 0;

  DateTime startDate = DateTime.now();
  int dayCount = 6;
  DateTime day = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<DateTime> hourList = [];

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  double? distance;
  String? duration;

  @override
  void initState() {
    super.initState();
    hourList = [
      day.add(const Duration(hours: 11)),
      day.add(const Duration(hours: 12, minutes: 10)),
      day.add(const Duration(hours: 13, minutes: 10)),
      day.add(const Duration(hours: 14, minutes: 10)),
    ];
  }

  // getMap() async {
  //   await Future.delayed(Duration(seconds: 3));
  //   return SizedBox(
  //     height: 200,
  //     child: GoogleMap(
  //         initialCameraPosition: CameraPosition(target: LatLng(11.1, 11.4))),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          title: const Text("Plan a book ride"),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              height: MediaQuery.of(context).size.height - kToolbarHeight - 48,
              child: Column(
                children: [
                  if (_fromLatLng != null && _toLatLng != null)
                    SizedBox(
                      height: 200,
                      child: RouteDirectionMap(
                        from: _fromLatLng!,
                        to: _toLatLng!,
                      ),
                    ),
                  // FutureBuilder(
                  //     future: getMap(),
                  //     builder: (context, AsyncSnapshot snapshot) {
                  //       if (snapshot.hasData) {
                  //         return snapshot.data;
                  //       } else
                  //         return SizedBox();
                  //     }),
                  // if (_estimate != null)
                  //   FutureBuilder(
                  //       future: MapRoutService()
                  //           .getDirection(_fromLatLng!, _toLatLng!),
                  //       builder: (BuildContext context,
                  //           AsyncSnapshot<Widget> snapshot) {
                  //         if (snapshot.hasData) {
                  //           return snapshot.data ??
                  //               Container(
                  //                 color: Colors.amber,
                  //                 height: 100,
                  //               );
                  //         } else
                  //           return SizedBox(
                  //             height: 100,
                  //           );
                  //       }),
                  _buildFromLocationWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildToLocationWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                  if (distance != null)
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/distance.png",
                                      height: 24,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Distance"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("$distance Km")
                                      ],
                                    )
                                  ],
                                ))),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/time.png",
                                      height: 24,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Duration"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("$duration")
                                      ],
                                    )
                                  ],
                                ))),
                      ],
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (distance != null)
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/receipt.png",
                              height: 24,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Fee"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text("${(distance! * 600).round() + 1500} Ks")
                              ],
                            )
                          ],
                        )),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(colorPrimary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFFFFFFFF),

                            // height: 19/19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

/*
  Widget _buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: hourList.map(
        (e) {
          int index = hourList.indexOf(e);
          return InkWell(
            onTap: () {
              setState(() {
                selectedTime = index;
              });
            },
            child: Container(
              width: (MediaQuery.of(context).size.width -
                      (8 * (hourList.length - 1)) -
                      40) /
                  hourList.length,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    selectedTime == index ? colorSecondaryVariant : colorGrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                DateFormat('h:mm a').format(e),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
*/
  Widget _buildFromLocationWidget() {
    return Container(
      color: Colors.white,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: _fromController,
        readOnly: true,
        maxLines: 1,
        keyboardType: TextInputType.multiline,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LocationPage();
              },
            ),
          ).then(
            (value) {
              _fromController.text = value[0];
              _fromLatLng = value[1];
              calculateDistance();
            },
          );
        },
        decoration: InputDecoration(
            hintText: 'Select Destination',
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Image.asset(
                "assets/navigation.png",
                height: 24,
                width: 24,
              ),
            )),
      ),
    );
  }

  calculateDistance() async {
    if (_fromLatLng == null && _toLatLng == null) return;
    // final s = CalculateDistance();
    // _estimate = await s.calculateEstimateDistance(_fromLatLng!, _toLatLng!);
    // setState(() {});
    final mapRouteService = MapRoutService();
    distance =
        await mapRouteService.calculateDistance(_fromLatLng!, _toLatLng!);
    duration =
        await mapRouteService.calculateEsimateTime(_fromLatLng!, _toLatLng!);
    setState(() {});
  }

  Widget _buildToLocationWidget() {
    return Container(
      color: Colors.white,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: _toController,
        readOnly: true,
        maxLines: 1,
        keyboardType: TextInputType.multiline,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LocationPage();
              },
            ),
          ).then((value) {
            _toController.text = value[0];
            _toLatLng = value[1];
            calculateDistance();
          });
        },
        decoration: InputDecoration(
          hintText: 'Select Destination',
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Image.asset(
              "assets/taxi.png",
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}
