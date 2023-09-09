import 'cloth_with_count_entity.dart';

class LaundryBookingConfirmEntity {
  final List<ClothWithCountEntity> clothList;
  final int totalCount;
  final double totalPrice;
  final String serviceName;

  LaundryBookingConfirmEntity({
    required this.clothList,
    required this.totalCount,
    required this.totalPrice,
    required this.serviceName,
  });
}
