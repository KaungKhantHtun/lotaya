import 'package:flutter/material.dart';

enum BookingStatus {
  requested("Requested"),
  pending("Pending"),
  pendingPayment("Pending Payment"),
  completed("Completed"),
  rejected("Rejected");

  final String name;
  const BookingStatus(this.name);

  Color get getColor {
    switch (this) {
      case BookingStatus.requested:
        return const Color(0xff3884e9);
      case BookingStatus.pending:
        return const Color(0xffebbd26);
      case BookingStatus.pendingPayment:
        return const Color(0xffebbd26);
      case BookingStatus.completed:
        return const Color(0xff64be62);
      case BookingStatus.rejected:
        return Colors.red;
      default:
        return const Color(0xff3884e9);
    }
  }

  static getStatus(String s) {
    switch (s) {
      case "Requested":
        return BookingStatus.requested;
      case "Pending":
        return BookingStatus.pending;
      case "Pending Payment":
        return BookingStatus.pendingPayment;
      case "Completed":
        return BookingStatus.completed;
      case "Rejected":
        return BookingStatus.rejected;
      default:
        return BookingStatus.pending;
    }
  }
}
