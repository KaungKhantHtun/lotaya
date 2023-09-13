enum WearType {
  outWear("Outwear"),
  casualWear("Casual wear"),
  formalWear("Formal wear");

  final String name;
  const WearType(this.name);
  static WearType getWearType(String value) {
    switch (value) {
      case "Casual wear":
        return WearType.casualWear;
      case "Formal wear":
        return WearType.formalWear;
      case "Outwear":
      default:
        return WearType.outWear;
    }
  }
}
