import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/presentation/widgets/address_field_widget.dart';
import 'package:hakathon_service/presentation/widgets/note_field_widget.dart';
import 'package:hakathon_service/presentation/widgets/total_cost_widget.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/service_provider_type.dart';
import '../../widgets/service_provider_select.dart';
import '../home/home_screen.dart';

class CleaningServiceScreen extends StatefulWidget {
  const CleaningServiceScreen({
    super.key,
  });

  @override
  State<CleaningServiceScreen> createState() => _CleaningServiceScreenState();
}

class _CleaningServiceScreenState extends State<CleaningServiceScreen> {
  String selectedServiceName = "";
  String selectedServicePlace = "";
  DateTime selectedServiceDate = DateTime.now();
  DateTime selectedServiceTime = DateTime.now();
  int selectedPlace = 1;
  int selectIdType = 0;
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

  TextEditingController _serviceProviderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hourList = [
      DateTime(day.year, day.month, day.day, 11),
      DateTime(day.year, day.month, day.day, 12, 10),
      DateTime(day.year, day.month, day.day, 13, 10),
      DateTime(day.year, day.month, day.day, 14, 10),
    ];
    selectedServiceName = "General Cleaning";
    List<DateTime> list = hourList
        .where((e) =>
            e.difference(DateTime.now()) > Duration(hours: priorOrderHour))
        .toList();
    if (list.isNotEmpty) {
      selectedServiceTime = list.first;
    } else {
      startDate = DateTime.now().add(const Duration(days: 1));
      hourList = [
        DateTime(startDate.year, startDate.month, startDate.day, 11),
        DateTime(startDate.year, startDate.month, startDate.day, 12, 10),
        DateTime(startDate.year, startDate.month, startDate.day, 13, 10),
        DateTime(startDate.year, startDate.month, startDate.day, 14, 10),
      ];
      selectedServiceTime = hourList.first;
    }
    selectedTime = hourList.indexOf(selectedServiceTime);
    price = getPrice(type: selectedServiceName, size: actualMaxSize);
    addCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: const Text(
          "CLEANING",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildHeader(),
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildServiceList(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildSizeSlider(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildDatePicker(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildTimePicker(),
                  const SizedBox(
                    height: 16,
                  ),
                  ServiceProviderSelect(
                    type: ServiceProviderType.homeCleaning,
                    serviceProviderController: _serviceProviderController,
                    onChanged: (value) {
                      _serviceProviderController.text = value;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AddressFieldWidget(
                    addressController: _addressController,
                    onChanged: (address, latlng) {
                      _addressController.text = address;
                      lat = latlng.latitude;
                      long = latlng.longitude;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  NoteFieldWidget(noteController: _noteController),
                  const SizedBox(
                    height: 16,
                  ),
                  TotalCostWidget(price: price),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildContinueButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getPrice({required String type, required int size}) {
    double basePrice = 5000;
    if (type == "Deep Cleaning") {
      basePrice = 7000;
    } else {
      basePrice = 5000;
    }
    if (size < 500) {
      return basePrice * 2;
    } else if (size > 500 && size < 1000) {
      return basePrice * 3;
    } else
    // if (size > 1000 && size < 1400)
    {
      return basePrice * 4;
    }
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/laundry.png",
    ).then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  // Widget _buildHeader() {
  //   return Container(
  //     height: 200,
  //     padding: const EdgeInsets.all(16),
  //     decoration: const BoxDecoration(
  //       color: headerSectionColor,
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(40),
  //         bottomRight: Radius.circular(40),
  //       ),
  //     ),
  //     child: Center(
  //       child: Row(
  //         children: [
  //           Expanded(
  //             flex: 3,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const SizedBox(
  //                   height: 30,
  //                 ),
  //                 Row(
  //                   children: [
  //                     ...List.generate(
  //                       widget.serviceProvider.rating,
  //                       (index) => const Icon(
  //                         Icons.star,
  //                         color: colorSecondary,
  //                         size: 16,
  //                       ),
  //                     ).toList(),
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: 4,
  //                 ),
  //                 Text(
  //                   widget.serviceProvider.serviceName,
  //                   style: headerStyle,
  //                   textAlign: TextAlign.left,
  //                 ),
  //                 const SizedBox(
  //                   height: 16,
  //                 ),
  //                 Flexible(
  //                   child: Text(
  //                     widget.serviceProvider.about,
  //                     style: regularStyle.copyWith(color: fontColorGrey),
  //                     textAlign: TextAlign.left,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 8,
  //                 ),
  //                 Text(
  //                   "${widget.serviceProvider.priceRate} Ks/Hr",
  //                   style: regularStyle.copyWith(
  //                       color: colorPrimary, fontWeight: FontWeight.w600),
  //                   textAlign: TextAlign.left,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Expanded(
  //             flex: 2,
  //             child: Container(),
  //           ),
  //           IconButton(
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => MapSample(
  //                       markers: [
  //                         Marker(
  //                           markerId: MarkerId("1"),
  //                           position: LatLng(16.844171, 96.085055),
  //                           icon: markerIcon,
  //                         ),
  //                         Marker(
  //                           markerId: MarkerId("2"),
  //                           position: LatLng(16.845986, 96.087491),
  //                           icon: markerIcon,
  //                         ),
  //                         Marker(
  //                           markerId: MarkerId("3"),
  //                           position: LatLng(16.840941, 96.087332),
  //                           icon: markerIcon,
  //                         ),
  //                         Marker(
  //                           markerId: MarkerId("4"),
  //                           position: LatLng(16.840868, 96.085035),
  //                           icon: markerIcon,
  //                         )
  //                       ],
  //                     ),
  //                   ));
  //             },
  //             icon: Image.asset("assets/map.png"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildServiceList() {
    double width = MediaQuery.of(context).size.width / 3 - 16;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cleaning Place",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildServiceCard(
              index: 0,
              name: "Home Clean",
              iconUrl: "assets/aircon.png",
              width: width,
              isSelected: selectedPlace == 0,
            ),
            const SizedBox(
              width: 16,
            ),
            _buildServiceCard(
              index: 1,
              name: "Vehicle washing",
              iconUrl: "assets/fridge.png",
              width: width,
              isSelected: selectedPlace == 1,
            ),
            const SizedBox(
              width: 16,
            ),
            _buildServiceCard(
              index: 2,
              name: "Shop Clean",
              iconUrl: "assets/oven.png",
              width: width,
              isSelected: selectedPlace == 2,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Service Type",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: _buildServiceType(
                  name: "General Cleaning",
                  index: 0,
                  isSelected: selectIdType == 0),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _buildServiceType(
                  name: "Deep Cleaning",
                  index: 1,
                  isSelected: selectIdType == 1),
            ),
          ],
        ),
      ],
    );
  }

  int minSize = 0;
  int maxSize = 1400;
  int defaultMinSize = 50;
  int defaultMaxSize = 1400;
  int actualMinSize = 50;
  int actualMaxSize = 1400;
  Widget _buildSizeSlider() {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Space Size",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTickMarkColor: colorPrimary,
              activeTrackColor: colorPrimary,
              overlayColor: colorPrimary.withOpacity(0.25),
              valueIndicatorColor: colorPrimary,
              thumbColor: Colors.white,
              overlappingShapeStrokeColor: Colors.white,
              trackHeight: 2.0,
            ),
            child: RangeSlider(
              inactiveColor: colorPrimary.withOpacity(0.4),
              min: defaultMinSize.toDouble(),
              max: defaultMaxSize.toDouble(),
              divisions: 50,
              labels: RangeLabels(
                actualMinSize == null
                    ? "$defaultMinSize sqft"
                    : "$actualMinSize sqft",
                actualMaxSize == null
                    ? "$defaultMaxSize sqft"
                    : "$actualMaxSize sqft",
              ),
              values: RangeValues(
                  actualMinSize.toDouble() ?? defaultMinSize.toDouble(),
                  actualMaxSize.toDouble() ?? defaultMaxSize.toDouble()),
              onChanged: (values) {
                setState(
                  () {
                    actualMinSize = values.start.toInt();
                    actualMaxSize = values.end.toInt();
                    price = getPrice(
                        type: selectedServiceName, size: actualMaxSize);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      {required String name,
      required String iconUrl,
      required double width,
      required bool isSelected,
      required int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPlace = index;
          selectedServicePlace = name;
        });
      },
      child: Container(
        // width: width,
        height: 40,
        padding: const EdgeInsets.only(bottom: 8, top: 8, left: 18, right: 18),
        decoration: BoxDecoration(
          color: isSelected ? colorPrimary : colorGrey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   iconUrl,
              //   width: 25,
              //   height: 25,
              //   color: isSelected ? Colors.white : Colors.black,
              // ),
              // const SizedBox(
              //   height: 4,
              // ),
              Text(
                name,
                style: regularStyle.copyWith(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceType(
      {required String name, required int index, required bool isSelected}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectIdType = index;
          selectedServiceName = name;
          price = getPrice(type: selectedServiceName, size: actualMaxSize);
        });
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
        decoration: BoxDecoration(
          color: isSelected ? colorSecondaryVariant : colorGrey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cleaning Date & Time",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            ...List.generate(
              dayCount,
              (index) {
                DateTime day = startDate.add(Duration(days: index));

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedServiceDate = day;
                          selectedDay = index;
                          hourList = [
                            DateTime(day.year, day.month, day.day, 11),
                            DateTime(day.year, day.month, day.day, 12, 10),
                            DateTime(day.year, day.month, day.day, 13, 10),
                            DateTime(day.year, day.month, day.day, 14, 10),
                          ];
                        });
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width -
                                (8 * (dayCount - 1)) -
                                40) /
                            dayCount,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: selectedDay == index
                              ? colorSecondaryVariant
                              : colorGrey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${day.day}",
                              textAlign: TextAlign.center,
                            ),
                            // Text(
                            //   DateFormat.E().format(day),
                            //   textAlign: TextAlign.center,
                            // ),
                            Text(
                              DateFormat.MMM().format(day),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: index != dayCount - 1 ? 8 : 0),
                  ],
                );
              },
            )
          ],
        ),
      ],
    );
  }

  int priorOrderHour = 2;
  Widget _buildTimePicker() {
    List<Widget> widgetList = [];
    for (int index = 0; index < hourList.length; index++) {
      bool canBook = hourList[index].difference(DateTime.now()) >
          Duration(hours: priorOrderHour);
      widgetList.add(
        InkWell(
          onTap: () {
            if (canBook) {
              setState(() {
                selectedServiceTime = hourList[index];
                selectedTime = index;
              });
            }
          },
          child: Container(
            width: (MediaQuery.of(context).size.width -
                    (8 * (hourList.length - 1)) -
                    40) /
                hourList.length,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: !canBook
                  ? Colors.grey[800]
                  : selectedTime == index
                      ? colorSecondaryVariant
                      : colorGrey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              DateFormat('h:mm a').format(hourList[index]),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: !canBook ? Colors.white : Colors.black),
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [...widgetList],
    );
  }

  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  Widget _buildContinueButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: ElevatedButton(
        onPressed: _addressController.text.isEmpty
            ? null
            : () async {
                await doBooking();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Confirm",
            style: regularStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  double lat = 12.345;
  double long = 13.456;
  double price = 5000;
  Future<void> doBooking() async {
    final CollectionReference bookingList =
        FirebaseFirestore.instance.collection(bookingTable);
    BookingEntity booking = BookingEntity(
      bookingId: "123",
      name: _serviceProviderController.text,
      serviceType: ServiceProviderType.homeCleaning,
      // serviceProviderId: widget.serviceProvider.serviceId,
      serviceName: selectedServiceName,
      serviceTime: DateTime(
        selectedServiceDate.year,
        selectedServiceDate.month,
        selectedServiceDate.day,
        selectedServiceTime.hour,
        selectedServiceTime.minute,
      ),
      bookingCreatedTime: DateTime.now(),
      bookingStatus: BookingStatus.serviceRequested,
      address: _addressController.text,
      lat: lat,
      long: long,
      price: price,
      note: _noteController.text,
      cleaningPlace: selectedServicePlace,
      cleaningServiceType: selectedServiceName,
      spaceSize: actualMaxSize,
    );
    try {
      await bookingList.add(booking.toJson());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeScreen(
                initialIndex: 1,
              )));
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }
}
