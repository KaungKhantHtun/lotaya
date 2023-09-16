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
import '../../../services/user_profile_service.dart';
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

  bool showTotal = false;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  TextEditingController _serviceProviderController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  int roomSize = 0;

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
    price = getPrice(type: selectedServiceName, size: roomSize);
    addCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorPrimary,
        backgroundColor: colorPrimaryLight,
        centerTitle: true,
        title: Text(
          "CLEANING",
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
              child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildServiceList(),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _sizeController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Size";
                          } else {
                            int size = int.tryParse(value) ?? 0;
                            if (size < 50) {
                              return "Our available room size is 50sqft to 5000 sqft.";
                            }
                            if (size > 5000) {
                              return "Our available room size is 50sqft to 5000 sqft.";
                            }
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            roomSize = int.tryParse(value) ?? 0;
                            showTotal = true;
                          });
                        },
                        decoration: const InputDecoration(
                          label: Text("Enter Room Size"),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          border: OutlineInputBorder(),
                          suffixText: "sqft",
                          suffixStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ),
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
                          showTotal = true;
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
                    ]),
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
    } else {
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
          showTotal = true;
        });
      },
      child: Container(
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
          price = getPrice(type: selectedServiceName, size: roomSize);
          showTotal = true;
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

  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  Widget _buildContinueButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: ElevatedButton(
        onPressed: _addressController.text.isEmpty ||
                _sizeController.text.isEmpty ||
                !_formkey.currentState!.validate()
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
      bookingId: "123",
      name: serviceProviderName,
      serviceType: ServiceProviderType.homeCleaning,
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
      spaceSize: roomSize,
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
