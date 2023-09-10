import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';

import 'booking_status.dart';

class BookingEntity {
  final String bookingId;
  final String name;
  final ServiceProviderType serviceType;
  final String serviceProviderId;
  final String serviceName;
  final DateTime serviceTime;
  final DateTime bookingCreatedTime;
  final String address;
  final BookingStatus bookingStatus;
  final double? long;
  final double? lat;
  final double? price;
  final String? note;

  BookingEntity({
    required this.bookingId,
    required this.name,
    required this.serviceType,
    required this.serviceProviderId,
    required this.serviceName,
    required this.serviceTime,
    required this.bookingCreatedTime,
    required this.address,
    required this.bookingStatus,
    this.long,
    this.lat,
    this.price,
    this.note,
  });
  Map<String, dynamic> toJson() {
    return {
      "bookingId": bookingId,
      "name": name,
      "serviceType": serviceType.name,
      "serviceProviderId": serviceProviderId,
      "serviceName": serviceName,
      "serviceTime": serviceTime,
      "bookingCreatedTime": bookingCreatedTime,
      "address": address,
      "bookingStatus": bookingStatus.name,
      "long": long,
      "lat": lat,
      "price": price,
      "note": note,
    };
  }

  static BookingEntity fromJson(Map<String, dynamic> map) {
    return BookingEntity(
      bookingId: map["bookingId"] ?? "",
      name: map["name"],
      serviceType: ServiceProviderType.getServiceProvider(map["serviceType"]),
      serviceProviderId: map["serviceProviderId"],
      serviceName: map["serviceName"],
      serviceTime: map["serviceTime"],
      bookingCreatedTime: map["bookingCreatedTime"],
      address: map["address"],
      bookingStatus: BookingStatus.getStatus(map["bookingStatus"]),
      long: map["long"],
      lat: map["lat"],
      price: map["price"],
      note: map["note"],
    );
  }



  static BookingEntity fromDoc(QueryDocumentSnapshot<Object?>? doc) {
    return BookingEntity(
      bookingId: doc?.data().toString().contains("bookingId") ?? false
          ? doc?.get("bookingId")
          : "",
      name: doc?.data().toString().contains("name") ?? false
          ? doc?.get("name")
          : "",
      serviceType: doc?.data().toString().contains("serviceType") ?? false
          ? ServiceProviderType.getServiceProvider(doc?.get("serviceType"))
          : ServiceProviderType.electronic,
      serviceProviderId:
          doc?.data().toString().contains("serviceProviderId") ?? false
              ? doc?.get("serviceProviderId")
              : "",
      serviceName: doc?.data().toString().contains("serviceName") ?? false
          ? doc?.get("serviceName")
          : "",
      serviceTime: doc?.data().toString().contains("serviceTime") ?? false
          ? (doc?.get("serviceTime") as Timestamp).toDate()
          : DateTime.now(),
      bookingCreatedTime:
          doc?.data().toString().contains("bookingCreatedTime") ?? false
              ? (doc?.get("bookingCreatedTime") as Timestamp).toDate()
              : DateTime.now(),
      address: doc?.data().toString().contains("address") ?? false
          ? doc?.get("address")
          : "",
      bookingStatus: BookingStatus.getStatus(
          doc?.data().toString().contains("bookingStatus") ?? false
              ? doc?.get("bookingStatus")
              : "Requested"),
    );
  }
}
