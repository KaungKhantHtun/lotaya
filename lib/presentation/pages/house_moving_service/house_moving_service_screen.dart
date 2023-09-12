import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/car_entity.dart';
import 'package:hakathon_service/presentation/widgets/note_field_widget.dart';
import 'package:hakathon_service/services/distance_service.dart';
import 'package:hakathon_service/services/map_service.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/service_provider_entity.dart';
import '../../../services/location_service.dart';
import '../home/home_screen.dart';

class HouseMovingServiceScreen extends StatefulWidget {
  const HouseMovingServiceScreen({super.key, required this.serviceProvider});
  final ServiceProviderEntity serviceProvider;

  @override
  State<HouseMovingServiceScreen> createState() =>
      _HouseMovingServiceScreenState();
}

class _HouseMovingServiceScreenState extends State<HouseMovingServiceScreen> {
  DateTime movingDate = DateTime.now();
  List<DateTime> hourList = [];
  DateTime selectedServiceDate = DateTime.now();
  DateTime selectedServiceTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 11);

  int selectedDay = 0;
  int selectedTime = 0;

  DateTime startDate = DateTime.now();
  int dayCount = 6;
  DateTime day = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  LatLng? _fromLatLng;
  LatLng? _toLatLng;
  DistanceAndDuration? _estimate;

  List<CarEntity> carList = [
    CarEntity(
        name: "Mini Truck",
        price: 40000,
        size: 2000,
        imgUrl: 'assets/mini-truck.png'),
    CarEntity(
        name: "Truck", price: 60000, size: 4000, imgUrl: 'assets/truck.png'),
    CarEntity(
        name: "Mini Truck",
        price: 40000,
        size: 2000,
        imgUrl: 'assets/mini-truck.png'),
    CarEntity(
        name: "Truck", price: 60000, size: 4000, imgUrl: 'assets/truck.png'),

    // CarEntity(name:,price:, size:,imgUrl: ''),
    // CarEntity(name:,price:, size:,imgUrl: ''),
  ];
  @override
  void initState() {
    super.initState();
    hourList = [
      DateTime(movingDate.year, movingDate.month, movingDate.day, 11),
      DateTime(movingDate.year, movingDate.month, movingDate.day, 12, 10),
      DateTime(movingDate.year, movingDate.month, movingDate.day, 13, 10),
      DateTime(movingDate.year, movingDate.month, movingDate.day, 14, 10),
    ];
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
    addCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFromLocationWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildToLocationWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildFloorWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildCarTypeWidget(),
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
                  NoteFieldWidget(noteController: _noteController),
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

  Widget _buildFromLocationWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffa1a2bd),
          ),
        ),
      ),
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
            labelText: "Moving From",
            // hintText: "Moving From",
            contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
            labelStyle: const TextStyle(
              color: Color(0xffa1a2bd),
            ),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
              child: Image.asset(
                "assets/location.png",
                height: 20,
                width: 20,
                color: colorPrimary,
              ),
            )),
      ),
    );
  }

  Widget _buildToLocationWidget() {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffa1a2bd),
          ),
        ),
      ),
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
          labelText: "Moving To",
          // hintText: 'Moving To',
          labelStyle: TextStyle(),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
            child: Image.asset(
              "assets/location.png",
              color: colorPrimary,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }

  int selectedCarIndex = 0;
  Widget _buildCarTypeWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: carList.map(
          (e) {
            int index = carList.indexOf(e);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    selectedCarIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    // width: 100,
                    height: 80,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selectedCarIndex == index
                          ? colorPrimary.withOpacity(0.4)
                          : colorPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.name,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${e.price} Ks",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            e.imgUrl,
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (index != carList.length - 1)
                  const SizedBox(
                    width: 16,
                  )
              ],
            );
          },
        ).toList(),
      ),
    );
  }

  calculateDistance() async {
    if (_fromLatLng == null && _toLatLng == null) return;
    final s = CalculateDistance();
    _estimate = await s.calculateEstimateDistance(_fromLatLng!, _toLatLng!);
    setState(() {});
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

  Widget _buildHeader() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: headerSectionColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        widget.serviceProvider.rating,
                        (index) => const Icon(
                          Icons.star,
                          color: colorSecondary,
                          size: 16,
                        ),
                      ).toList(),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.serviceProvider.serviceName,
                    style: headerStyle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Flexible(
                    child: Text(
                      widget.serviceProvider.about,
                      style: regularStyle.copyWith(color: fontColorGrey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.serviceProvider.priceRate} Ks/Hr",
                    style: regularStyle.copyWith(
                        color: colorPrimary, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapSample(
                        markers: [
                          Marker(
                            markerId: MarkerId("1"),
                            position: LatLng(16.844171, 96.085055),
                            icon: markerIcon,
                          ),
                          Marker(
                            markerId: MarkerId("2"),
                            position: LatLng(16.845986, 96.087491),
                            icon: markerIcon,
                          ),
                          Marker(
                            markerId: MarkerId("3"),
                            position: LatLng(16.840941, 96.087332),
                            icon: markerIcon,
                          ),
                          Marker(
                            markerId: MarkerId("4"),
                            position: LatLng(16.840868, 96.085035),
                            icon: markerIcon,
                          )
                        ],
                      ),
                    ));
              },
              icon: Image.asset("assets/map.png"),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _floorList = const [
    "1st Floor",
    "2nd Floor",
    "3rd Floor",
    "4th Floor",
    "5th Floor"
        "6th Floor"
        "7th Floor"
  ];
  String _selectedFloor = "1st Floor";

  Widget _buildFloorWidget() {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            isExpanded: true,
            underline: Container(
                padding: const EdgeInsets.only(top: 16),
                child: const Divider(color: colorPrimary)),
            // dropdownColor: colorPrimary,
            iconEnabledColor: colorPrimary,
            iconDisabledColor: colorPrimary,
            focusColor: colorPrimary,
            value: _selectedFloor,
            icon: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Icon(
                Icons.arrow_drop_down,
                color: colorPrimary,
                size: 24,
              ),
            ),
            onChanged: (newValue) {
              setState(() {
                _selectedFloor = newValue!;
              });
            },
            selectedItemBuilder: (context) {
              return _floorList.map<Widget>((String item) {
                return Container(
                  padding: const EdgeInsets.only(left: 12, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/building.png",
                        width: 24,
                        height: 24,
                        color: colorPrimary,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(item),
                    ],
                  ),
                );
              }).toList();
              // Container(height: 10, color: Colors.red);
            },

            items: _floorList.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date & Time",
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

  TextEditingController _noteController = TextEditingController();

  Widget _buildContinueButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: ElevatedButton(
        onPressed: () async {
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
      bookingId: "house123",
      name: widget.serviceProvider.serviceName,
      serviceType: widget.serviceProvider.serviceType,
      serviceProviderId: widget.serviceProvider.serviceId,
      serviceName: "House Moving",
      serviceTime: DateTime(
        selectedServiceDate.year,
        selectedServiceDate.month,
        selectedServiceDate.day,
        selectedServiceTime.hour,
        selectedServiceTime.minute,
      ),
      bookingCreatedTime: DateTime.now(),
      bookingStatus: BookingStatus.serviceRequested,
      address: _fromController.text,
      lat: _fromLatLng?.latitude,
      long: _fromLatLng?.longitude,
      price: price,
      note: _noteController.text,
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
