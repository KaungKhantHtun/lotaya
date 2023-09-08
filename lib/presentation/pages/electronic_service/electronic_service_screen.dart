import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/presentation/pages/location_screen.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/service_provider_entity.dart';
import '../home/home_screen.dart';

class ElectronicServiceScreen extends StatefulWidget {
  const ElectronicServiceScreen({super.key, required this.serviceProvider});
  final ServiceProviderEntity serviceProvider;

  @override
  State<ElectronicServiceScreen> createState() =>
      _ElectronicServiceScreenState();
}

class _ElectronicServiceScreenState extends State<ElectronicServiceScreen> {
  String selectedServiceName = "";
  DateTime selectedServiceDate = DateTime.now();
  DateTime selectedServiceTime = DateTime.now();
  int selectedDevice = 1;
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

  @override
  void initState() {
    super.initState();
    hourList = [
      DateTime(day.year, day.month, day.day, 11),
      DateTime(day.year, day.month, day.day, 12, 10),
      DateTime(day.year, day.month, day.day, 13, 10),
      DateTime(day.year, day.month, day.day, 14, 10),
    ];
    selectedServiceName = "General Service";
    selectedServiceTime = hourList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _buildServiceList(),
                  const SizedBox(
                    height: 32,
                  ),
                  _buildDatePicker(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildTimePicker(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildLocationWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildNotefieldWidget(),
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
          ],
        ),
      ),
    );
  }

  Widget _buildServiceList() {
    double width = MediaQuery.of(context).size.width / 3 - 16 * 2;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildServiceCard(
                index: 0,
                name: "AC",
                iconUrl: "assets/aircon.png",
                width: width,
                isSelected: selectedDevice == 0,
              ),
              const SizedBox(
                width: 16,
              ),
              _buildServiceCard(
                index: 1,
                name: "Fridge",
                iconUrl: "assets/fridge.png",
                width: width,
                isSelected: selectedDevice == 1,
              ),
              const SizedBox(
                width: 16,
              ),
              _buildServiceCard(
                index: 2,
                name: "Oven",
                iconUrl: "assets/oven.png",
                width: width,
                isSelected: selectedDevice == 2,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: _buildServiceType(
                  name: "General Service",
                  index: 0,
                  isSelected: selectIdType == 0),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _buildServiceType(
                  name: "Gas Recharge",
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
          selectedDevice = index;
        });
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.only(bottom: 8, top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: isSelected ? colorPrimary : colorGrey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconUrl,
              width: 25,
              height: 25,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              name,
              style: regularStyle.copyWith(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
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
        });
      },
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: isSelected ? colorSecondaryVariant : colorGrey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
        ),
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
                              DateFormat.E().format(day),
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
                    SizedBox(width: index != dayCount ? 8 : 0),
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
      // children: hourListMap.map(
      //   (index, e) {
      //     bool canBook =
      //         e.difference(DateTime.now()) > Duration(hours: priorOrderHour);
      //     return InkWell(
      //       onTap: () {
      //         if (canBook) {
      //           setState(() {
      //             selectedServiceTime = e;
      //             selectedTime = index;
      //           });
      //         }
      //       },
      //       child: Container(
      //         width: (MediaQuery.of(context).size.width -
      //                 (8 * (hourList.length - 1)) -
      //                 40) /
      //             hourList.length,
      //         padding: const EdgeInsets.all(12),
      //         decoration: BoxDecoration(
      //           color: !canBook
      //               ? Colors.grey[800]
      //               : selectedTime == index
      //                   ? colorSecondaryVariant
      //                   : colorGrey,
      //           borderRadius: BorderRadius.circular(8.0),
      //         ),
      //         child: Text(
      //           DateFormat('h:mm a').format(e),
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //               fontWeight: FontWeight.w300,
      //               color: !canBook ? Colors.white : Colors.black),
      //         ),
      //       ),
      //     );
      //   },
      // ).toList(),
    );
  }

  Widget _buildLocationWidget() {
    return TextField(
      controller: _addressController,
      maxLines: 1,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: 'Your Address',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.gps_fixed),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LocationScreen()));
          },
        ),
      ),
    );
  }

  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  Widget _buildNotefieldWidget() {
    return TextField(
      controller: _noteController,
      maxLines: 4, // Allows unlimited lines of text
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        hintText: 'Note for service (optional)',
        border: OutlineInputBorder(),
      ),
    );
  }

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
      name: widget.serviceProvider.serviceName,
      serviceType: widget.serviceProvider.serviceType,
      serviceProviderId: widget.serviceProvider.serviceId,
      serviceName: selectedServiceName,
      serviceTime: DateTime(
        selectedServiceDate.year,
        selectedServiceDate.month,
        selectedServiceDate.day,
        selectedServiceTime.hour,
        selectedServiceTime.minute,
      ),
      bookingCreatedTime: DateTime.now(),
      address: _addressController.text,
      lat: lat,
      long: long,
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
