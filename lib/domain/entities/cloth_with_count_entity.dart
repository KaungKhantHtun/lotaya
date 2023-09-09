class ClothWithCountEntity {
  final String clothId;
  final int count;

  ClothWithCountEntity({required this.clothId, required this.count});

  ClothWithCountEntity copyWith({required int newCount}) {
    return ClothWithCountEntity(clothId: clothId, count: newCount);
  }
}
