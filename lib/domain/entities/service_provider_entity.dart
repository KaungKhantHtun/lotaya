import 'service_provider_type.dart';

class ServiceProviderEntity {
  final String serviceName;
  final String about;
  final double priceRate;
  final ServiceProviderType serviceType;
  final int rating;

  ServiceProviderEntity(
      {required this.serviceName,
      required this.about,
      required this.priceRate,
      required this.serviceType,
      required this.rating});
}
