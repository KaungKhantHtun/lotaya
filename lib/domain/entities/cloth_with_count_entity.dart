import 'package:hakathon_service/domain/entities/laundry_service_type.dart';

import 'wear_type.dart';

class ClothWithCountEntity {
  final String name;
  final String imgUrl;
  final String clothId;
  final int count;
  final LaundryServiceType serviceType;
  final double price;
  final WearType? wearType;

  ClothWithCountEntity(
      {this.wearType,
      required this.imgUrl,
      required this.name,
      required this.serviceType,
      required this.price,
      required this.clothId,
      required this.count});
  double get totalPrice => count * price;

  ClothWithCountEntity fromJson(Map<String, dynamic> json) {
    return ClothWithCountEntity(
      name: json['name'],
      imgUrl: json['imgUrl'],
      price: json['price'],
      clothId: json['clothId'],
      count: json['count'],
      serviceType:
          LaundryServiceType.getLaundryServiceType(json['serviceType']),
      wearType: WearType.getWearType(json['wearType']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imgUrl'] = imgUrl;
    data['price'] = price;
    data['clothId'] = clothId;
    data['count'] = count;
    data['serviceType'] = serviceType.name;
    data['wearType'] = wearType?.name;
    return data;
  }
}
