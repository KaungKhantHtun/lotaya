import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/presentation/widgets/address_field_widget.dart';
import 'package:hakathon_service/presentation/widgets/note_field_widget.dart';

import '../../../domain/entities/laundry_booking_confirm_entity.dart';
import '../../../domain/entities/service_provider_entity.dart';
import '../../../utils/constants.dart';
import '../home/home_screen.dart';

class LaundryOrderConfirmScreen extends StatefulWidget {
  const LaundryOrderConfirmScreen({
    super.key,
    required this.serviceProvider,
    required this.laundryBookingConfirmEntity,
  });
  final ServiceProviderEntity serviceProvider;
  final LaundryBookingConfirmEntity laundryBookingConfirmEntity;

  @override
  State<LaundryOrderConfirmScreen> createState() =>
      _LaundryOrderConfirmScreenState();
}

class _LaundryOrderConfirmScreenState extends State<LaundryOrderConfirmScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: Row(
                  children: const [
                    SizedBox(
                      width: 9,
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "Confirm Booking",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Cloth Type",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Price",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Quantity",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey.shade500),
                      ...widget.laundryBookingConfirmEntity.clothList.map(
                        (e) {
                          if (e.count <= 0) {
                            return Container();
                          }
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(e.name),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(e.price.toString()),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    e.count.toString(),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text("${e.count * e.price} Ks"),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                      Divider(color: Colors.grey.shade500),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              flex: 4,
                              child: Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                widget.laundryBookingConfirmEntity.totalCount
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${widget.laundryBookingConfirmEntity.totalPrice} Ks"
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 16,
              ),
              AddressFieldWidget(addressController: _addressController),
              const SizedBox(
                height: 16,
              ),
              NoteFieldWidget(noteController: _noteController),
              const SizedBox(
                height: 16,
              ),
              _buildContinueButton()
            ],
          ),
        ),
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

  Future<void> doBooking() async {
    final CollectionReference bookingList =
        FirebaseFirestore.instance.collection(bookingTable);
    double lat = 23;
    double long = 34;
    BookingEntity booking = BookingEntity(
      bookingId: "123",
      name: widget.serviceProvider.serviceName,
      serviceType: widget.serviceProvider.serviceType,
      serviceProviderId: widget.serviceProvider.serviceId,
      serviceName: "Laundry",
      serviceTime: DateTime.now(),
      bookingCreatedTime: DateTime.now(),
      bookingStatus: BookingStatus.pending,
      address: _addressController.text,
      lat: lat,
      long: long,
      price: widget.laundryBookingConfirmEntity.totalPrice,
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
