class CarEntity {
  final String name;
  final String imgUrl;
  final int size;
  final int price;

  CarEntity(
      {required this.name,
      required this.imgUrl,
      required this.size,
      required this.price});

  CarEntity fromJson(Map<String, dynamic> json) {
    return CarEntity(
      name: json['name'],
      imgUrl: json['imgUrl'],
      size: json['size'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imgUrl'] = imgUrl;
    data['size'] = size;
    data['price'] = price;
    return data;
  }
}
