import 'package:flutter/material.dart';

enum BookingStatus {
  serviceRequested("Service Requested",),
  pendingPayment("Pending Payment"),
  bookingAccepted("Booking Accepted"),
  serviceProcessing("Service Processing"),
  serviceFinished("Service Finished"),
  completed("Completed"),
  rejected("Rejected"),
  canceled("Canceled");

  final String name;
  const BookingStatus(this.name);

  Color get getColor {
    switch (this) {
      case BookingStatus.serviceRequested:
        return const Color(0xffe6f0fd);
      case BookingStatus.bookingAccepted:
        return const Color(0xfff3e6fd);
      case BookingStatus.pendingPayment:
        return const Color(0xfffdf3e6);
      case BookingStatus.serviceProcessing:
        return const Color(0xfff3e6fd);
      case BookingStatus.serviceFinished:
        return const Color(0xfff0fde6);
      case BookingStatus.completed:
        return const Color(0xff64be62);
      case BookingStatus.rejected:
        return Colors.red;
      case BookingStatus.canceled:
        return Colors.red;
      default:
        return const Color(0xff3884e9);
    }
  }

  static getStatus(String s) {
    switch (s) {
      case "Service Requested":
        return BookingStatus.serviceRequested;
      case "Pending Payment":
        return BookingStatus.pendingPayment;
      case "Booking Accepted":
        return BookingStatus.bookingAccepted;
      case "Service Processing":
        return BookingStatus.serviceProcessing;
      case "Service Finished":
        return BookingStatus.serviceFinished;
      case "Completed":
        return BookingStatus.completed;
      case "Canceled":
        return BookingStatus.canceled;
      case "Rejected":
        return BookingStatus.rejected;
      default:
        return BookingStatus.serviceRequested;
    }
  }
}
