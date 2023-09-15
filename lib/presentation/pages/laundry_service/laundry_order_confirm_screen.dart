import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/presentation/widgets/address_field_widget.dart';
import 'package:hakathon_service/presentation/widgets/note_field_widget.dart';

import '../../../domain/entities/laundry_booking_confirm_entity.dart';
import '../../../utils/constants.dart';
import '../../widgets/service_provider_select.dart';
import '../home/home_screen.dart';

class LaundryOrderConfirmScreen extends StatefulWidget {
  const LaundryOrderConfirmScreen({
    super.key,
    required this.laundryBookingConfirmEntity,
  });
  final LaundryBookingConfirmEntity laundryBookingConfirmEntity;

  @override
  State<LaundryOrderConfirmScreen> createState() =>
      _LaundryOrderConfirmScreenState();
}

class _LaundryOrderConfirmScreenState extends State<LaundryOrderConfirmScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _serviceProviderController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  double lat = 0.0;
  double long = 0.0;
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
                      color: Colors.white,
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
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorPrimary,
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
                              flex: 3,
                              child: Text(
                                "Cloth",
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Service",
                                maxLines: 2,
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
                                textAlign: TextAlign.right,
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
                                  flex: 3,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(e.serviceType.name),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    e.price.toInt().toString(),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    e.count.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${(e.count * e.price).toInt()} Ks",
                                    textAlign: TextAlign.right,
                                  ),
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
                              flex: 3,
                              child: Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Expanded(
                              flex: 5,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                widget.laundryBookingConfirmEntity.totalCount
                                    .toString(),
                                textAlign: TextAlign.center,
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
              ServiceProviderSelect(
                type: ServiceProviderType.laundry,
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

  Future<void> doBooking() async {
    String serviceProviderName = _serviceProviderController.text;
    if (serviceProviderName == "") {
      serviceProviderName = electronicList.first.serviceName;
    }
    final CollectionReference bookingList =
        FirebaseFirestore.instance.collection(bookingTable);
    double lat = 23;
    double long = 34;
    BookingEntity booking = BookingEntity(
      bookingId: "123",
      name: serviceProviderName,
      serviceType: ServiceProviderType.laundry,
      // serviceProviderId: widget.serviceProvider.serviceId,
      serviceName: "Laundry",
      serviceTime: DateTime.now(),
      bookingCreatedTime: DateTime.now(),
      bookingStatus: BookingStatus.serviceRequested,
      address: _addressController.text,
      lat: lat,
      long: long,
      price: widget.laundryBookingConfirmEntity.totalPrice,
      note: _noteController.text,
      clothList: widget.laundryBookingConfirmEntity.clothList,
      totalClothCount: widget.laundryBookingConfirmEntity.totalCount,
      totalLaundryPrice: widget.laundryBookingConfirmEntity.totalPrice,
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
