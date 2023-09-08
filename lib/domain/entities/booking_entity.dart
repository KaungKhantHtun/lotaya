import 'package:hakathon_service/domain/entities/service_provider_type.dart';

class BookingEntity {
  final String name;
  final ServiceProviderType serviceType;
  final String serviceProviderId;
  final String serviceName;
  final DateTime serviceTime;
  final DateTime bookingCreatedTime;
  final String address;
  final double? long;
  final double? lat;
  final double? price;
  final String? note;

  BookingEntity({
    required this.name,
    required this.serviceType,
    required this.serviceProviderId,
    required this.serviceName,
    required this.serviceTime,
    required this.bookingCreatedTime,
    required this.address,
    this.long,
    this.lat,
    this.price,
    this.note,
  });
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "serviceType": serviceType.name,
      "serviceProviderId": serviceProviderId,
      "serviceName": serviceName,
      "serviceTime": serviceTime,
      "bookingCreatedTime": bookingCreatedTime,
      "address": address,
      "long": long,
      "lat": lat,
      "price": price,
      "note": note,
    };
  }
}
