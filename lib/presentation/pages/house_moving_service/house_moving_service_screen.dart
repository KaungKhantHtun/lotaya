import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/car_entity.dart';
import 'package:hakathon_service/presentation/widgets/note_field_widget.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/service_provider_type.dart';
import '../../../services/location_service.dart';
import '../../../services/user_profile_service.dart';
import '../../widgets/service_provider_select.dart';
import '../../widgets/total_cost_widget.dart';
import '../home/home_screen.dart';

class HouseMovingServiceScreen extends StatefulWidget {
  const HouseMovingServiceScreen({
    super.key,
  });

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

  bool showTotal = false;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _serviceProviderController =
      TextEditingController();

  LatLng? _fromLatLng;
  LatLng? _toLatLng;
  late CarEntity _selectedCar;

  List<CarEntity> carList = [
    CarEntity(
        name: "Truck (12 ft)",
        price: 40000,
        size: 4000,
        imgUrl: 'assets/moving-truck.png'),
    CarEntity(
        name: "Truck (14 ft)",
        price: 50000,
        size: 2000,
        imgUrl: 'assets/moving-truck.png'),
    CarEntity(
        name: "Truck (16 ft)",
        price: 60000,
        size: 4000,
        imgUrl: 'assets/moving-truck.png'),
  ];
  @override
  void initState() {
    super.initState();
    _selectedCar = carList.first;
    price = _selectedCar.price.toDouble();
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
         foregroundColor: colorPrimary,
        backgroundColor: colorPrimaryLight,
        centerTitle: true,
        title: const Text(
          "HOME MOVING",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  ServiceProviderSelect(
                    type: ServiceProviderType.houseMoving,
                    serviceProviderController: _serviceProviderController,
                    onChanged: (value) {
                      _serviceProviderController.text = value;
                      showTotal = true;
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
                  if (showTotal) TotalCostWidget(price: price),
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
    return TextFormField(
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
          contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
          labelStyle: const TextStyle(),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          prefixIcon: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 8, top: 12, bottom: 12),
            child: Image.asset(
              "assets/location.png",
              height: 16,
              width: 16,
              color: colorPrimary,
            ),
          )),
    );
  }

  Widget _buildToLocationWidget() {
    return TextFormField(
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
        contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        prefixIcon: Padding(
          padding:
              const EdgeInsets.only(left: 0, right: 8, top: 12, bottom: 12),
          child: Image.asset(
            "assets/location.png",
            color: colorPrimary,
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }

  int selectedCarIndex = 0;
  Widget _buildCarTypeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Car Type",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
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
                        _selectedCar = e;
                        price = _selectedCar.price.toDouble();
                        showTotal = true;
                        setState(() {});
                      },
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selectedCarIndex == index
                              ? colorPrimary.withOpacity(0.3)
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
        ),
      ],
    );
  }

  calculateDistance() async {}

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

  List<String> _floorList = const [
    "Ground Floor",
    "1st Floor",
    "2nd Floor",
    "3rd Floor",
    "4th Floor",
    "5th Floor"
        "6th Floor"
        "7th Floor"
  ];
  String _selectedFloor = "Ground Floor";

  Widget _buildFloorWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        borderRadius: BorderRadius.circular(16),
        // underline: Container(
        //     padding: const EdgeInsets.only(top: 16),
        //     child: const Divider(color: colorPrimary)),
        iconEnabledColor: colorPrimary,
        iconDisabledColor: colorPrimary,
        focusColor: colorPrimary,
        value: _selectedFloor,
        underline: const SizedBox(),
        icon: Container(
          padding: const EdgeInsets.only(right: 8, top: 12, bottom: 12),
          child: const Icon(
            Icons.arrow_drop_down,
            color: colorPrimary,
            size: 20,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _selectedFloor = newValue!;
            showTotal = true;
          });
        },
        selectedItemBuilder: (context) {
          return _floorList.map<Widget>((String item) {
            return Container(
              padding: const EdgeInsets.only(left: 12, bottom: 0),
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
        },
        items: _floorList.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
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
                          showTotal = true;
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
                showTotal = true;
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
        onPressed: _fromController.text.isEmpty || _toController.text.isEmpty
            ? null
            : () async {
                await doBooking();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
    String serviceProviderName = _serviceProviderController.text;
    if (serviceProviderName == "") {
      serviceProviderName = electronicList.first.serviceName;
    }
    final CollectionReference bookingList =
        FirebaseFirestore.instance.collection(bookingTable);
    BookingEntity booking = BookingEntity(
      msisdn: UserProfileService.msisdn,
      bookingId: "house123",
      name: serviceProviderName,
      serviceType: ServiceProviderType.houseMoving,
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
      fromLat: _fromLatLng?.latitude,
      fromLong: _fromLatLng?.longitude,
      toLat: _toLatLng?.latitude,
      toLong: _toLatLng?.longitude,
      fromAddr: _fromController.text,
      toAddr: _toController.text,
      floorNo: _selectedFloor,
      carName: _selectedCar.name,
      carImgUrl: _selectedCar.imgUrl,
      carSize: _selectedCar.size,
      carPrice: _selectedCar.price,
    );
    try {
      await bookingList.add(booking.toJson()).then((value) {
        bookingList.doc(value.id).update({"bookingId": value.id});
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeScreen(
                initialIndex: 1,
              )));
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }
}
