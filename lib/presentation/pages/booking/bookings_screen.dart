import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  BookingEntity booking1 = BookingEntity(
    name: "Fix You Service",
    serviceType: ServiceProviderType.electronic,
    serviceProviderId: "1",
    serviceName: "Home Appliance Repair",
    serviceTime: DateTime.now(),
    bookingCreatedTime: DateTime.now(),
    address: "No.34, Yadanar Theinkha Street, Kyun Taw Road, Yangon",
    long: 12355.45,
    lat: 12345.45,
    price: 5000,
    note: "abc",
  );
  List<BookingEntity> bookingList = [];
  @override
  void initState() {
    // TODO: implement initState
    bookingList = [
      booking1,
      booking1,
      booking1,
      booking1,
      booking1,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: false,
        title: const Text("Bookings"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...bookingList
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 1, child: Text(e.name)),
                              Expanded(
                                  flex: 1, child: Text(e.serviceType.name)),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: const Text("Service Name:"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(e.serviceName),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text("Service Time:")),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${DateFormat.yMMMMEEEEd().format(e.serviceTime)} ${DateFormat('h:mm a').format(e.serviceTime)}",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text("")),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${DateFormat.yMMMMEEEEd().format(e.bookingCreatedTime)} ${DateFormat('h:mm a').format(e.bookingCreatedTime)}",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
