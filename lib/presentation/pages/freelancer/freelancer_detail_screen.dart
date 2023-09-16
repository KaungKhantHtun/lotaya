import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/freelancer_entity.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../../services/user_profile_service.dart';
import '../../widgets/address_field_widget.dart';
import '../../widgets/note_field_widget.dart';
import '../../widgets/total_cost_widget.dart';
import '../home/home_screen.dart';

class FreelacerDetailScreen extends StatefulWidget {
  FreelacerDetailScreen({
    super.key,
    required this.freelancer,
    required this.imgUrl,
    required this.name,
  });

  final FreelancerEntity freelancer;
  final String name;
  final String imgUrl;
  @override
  State<FreelacerDetailScreen> createState() => _FreelacerDetailScreenState();
}

class _FreelacerDetailScreenState extends State<FreelacerDetailScreen> {
  DateTime selectedServiceDate = DateTime.now();
  DateTime selectedServiceTime = DateTime.now();
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

  @override
  void initState() {
    super.initState();
    hourList = [
      DateTime(day.year, day.month, day.day, 11),
      DateTime(day.year, day.month, day.day, 12, 10),
      DateTime(day.year, day.month, day.day, 13, 10),
      DateTime(day.year, day.month, day.day, 14, 10),
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
  }

  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          "${widget.freelancer.type.name.toUpperCase()} DETAILS",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.imgUrl,
              fit: BoxFit.cover,
              height: 320,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    // TODO
                    // widget.freelancer.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.freelancer.hourlyRate} Ks/hr",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorPrimaryLight,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$15K+",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Total Earned",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorPrimaryLight,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "110",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Job Completed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorPrimaryLight,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "210",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Hours Worked",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                      ),
                      Text(
                        widget.freelancer.location,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(),
                  Text(
                    "Bio",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.freelancer.bio,
                    // faker.lorem.sentence() * 20,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
                  _buildWorkingHourWidget(),
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
                  const SizedBox(
                    height: 16,
                  ),
                  _buildContinueButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

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
    price = _selectedWorkingHour * widget.freelancer.hourlyRate.toDouble();
    final CollectionReference bookingList =
        FirebaseFirestore.instance.collection(bookingTable);
    BookingEntity booking = BookingEntity(
      msisdn: UserProfileService.msisdn,
      bookingId: "123",
      // TODO
      name: widget.name,
      // name: widget.freelancer.name,
      serviceType: ServiceProviderType.freelancer,
      serviceName: widget.freelancer.type.name,
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
      workingHours: _selectedWorkingHour,
      freelancerName: widget.name,
      freelancerType: widget.freelancer.type,
      freelancerPhoneNumber: widget.freelancer.phoneNumber,
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
                        showTotal = true;
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

  List<int> _workingHourList = const [
    1,
    2,
    3,
    4,
    5,
  ];
  int _selectedWorkingHour = 1;

  Widget _buildWorkingHourWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Center(
        child: DropdownButton<int>(
          hint: const Text("Select Working Hour"),
          borderRadius: BorderRadius.circular(16.0),
          isExpanded: true,
          iconEnabledColor: colorPrimary,
          iconDisabledColor: colorPrimary,
          underline: const SizedBox(),
          value: _selectedWorkingHour,
          icon: Container(
            padding: const EdgeInsets.only(right: 8),
            child: const Icon(
              Icons.arrow_drop_down,
              color: colorPrimary,
              size: 24,
            ),
          ),
          onChanged: (newValue) {
            setState(() {
              _selectedWorkingHour = newValue!;
              showTotal = true;
            });
          },
          selectedItemBuilder: (context) {
            return _workingHourList.map<Widget>((int item) {
              return Container(
                padding: const EdgeInsets.only(left: 12, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/working_hour.png",
                      width: 24,
                      height: 24,
                      color: colorPrimary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text("$item ${(item > 1) ? " hours" : " hour"}"),
                  ],
                ),
              );
            }).toList();
          },
          items: _workingHourList.map((int item) {
            return DropdownMenuItem<int>(
              value: item,
              child: Text("$item ${(item > 1) ? " hours" : " hour"}"),
            );
          }).toList(),
        ),
      ),
    );
  }
}
