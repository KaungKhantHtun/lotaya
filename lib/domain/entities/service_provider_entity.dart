import 'service_provider_type.dart';

class ServiceProviderEntity {
  final String serviceId;
  final String imgUrl;
  final String serviceName;
  final String about;
  final double priceRate;
  final ServiceProviderType serviceType;
  final int rating;
  final String address;

  ServiceProviderEntity({
    required this.serviceId,
    required this.serviceName,
    required this.imgUrl,
    required this.about,
    required this.priceRate,
    required this.serviceType,
    required this.rating,
    required this.address,
  });
}
