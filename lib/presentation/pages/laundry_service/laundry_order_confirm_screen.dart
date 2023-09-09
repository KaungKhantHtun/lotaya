import 'package:flutter/material.dart';

class LaundryOrderConfirmScreen extends StatefulWidget {
  const LaundryOrderConfirmScreen({super.key});

  @override
  State<LaundryOrderConfirmScreen> createState() =>
      _LaundryOrderConfirmScreenState();
}

class _LaundryOrderConfirmScreenState extends State<LaundryOrderConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }

  // Future<void> doBooking() async {

  //   final CollectionReference bookingList =
  //       FirebaseFirestore.instance.collection(bookingTable);
  //   BookingEntity booking = BookingEntity(
  //     bookingId: "123",
  //     name: widget.serviceProvider.serviceName,
  //     serviceType: widget.serviceProvider.serviceType,
  //     serviceProviderId: widget.serviceProvider.serviceId,
  //     serviceName: "Laundry",
  //     serviceTime: DateTime.now(),
  //     bookingCreatedTime: DateTime.now(),
  //     bookingStatus: BookingStatus.pending,
  //     address: _addressController.text,
  //     lat: lat,
  //     long: long,
  //     price: price,
  //     note: _noteController.text,
  //   );
  //   try {
  //     await bookingList.add(booking.toJson());
  //     Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => const HomeScreen(
  //               initialIndex: 1,
  //             )));
  //   } catch (e) {
  //     print('Error retrieving data: $e');
  //   }
  // }
}
