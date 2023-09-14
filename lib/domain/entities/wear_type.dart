enum WearType {
  others("Others"),
  clothes("Clothes"),
  outWear("OutWear"),
  homeAccessories("Home Accessories");

  final String name;
  const WearType(this.name);
  static WearType getWearType(String value) {
    switch (value) {
      case "Clothes":
        return WearType.clothes;
      case "OutWear":
        return WearType.outWear;
      case "Home Accessories":
        return WearType.homeAccessories;
      case "Others":
      default:
        return WearType.others;
    }
  }
}
