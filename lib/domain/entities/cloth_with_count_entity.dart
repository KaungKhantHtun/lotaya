import 'package:hakathon_service/domain/entities/laundry_service_type.dart';

class ClothWithCountEntity {
  final String name;
  final String clothId;
  final int count;
  final LaundryServiceType serviceType;
  final double price;

  ClothWithCountEntity(
      {required this.name,
      required this.serviceType,
      required this.price,
      required this.clothId,
      required this.count});
}
