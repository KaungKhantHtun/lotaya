import 'laundry_service_type.dart';
import 'wear_type.dart';

class ClothEntity {
  final String id;
  final String name;
  final String imgUrl;
  final WearType wearType;
  final double dryCleanPrice;
  final double washAndIconPrice;
  final double ironPrice;

  ClothEntity({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.wearType,
    required this.dryCleanPrice,
    required this.washAndIconPrice,
    required this.ironPrice,
  });

  double getPrice(LaundryServiceType type) {
    switch (type) {
      case LaundryServiceType.dryCleaning:
        return dryCleanPrice;
      case LaundryServiceType.washAndIron:
        return washAndIconPrice;
      case LaundryServiceType.iron:
        return ironPrice;
      default:
        return washAndIconPrice;
    }
  }
}
