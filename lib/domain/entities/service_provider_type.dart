enum ServiceProviderType {
  electronic("Electronic"),
  delivery("Delivery"),
  homeCleaning(
    "Home Cleaning",
  ),
  houseMoving("House Moving"),
  laundry("Laundry");

  final String name;
  const ServiceProviderType(this.name);
  static ServiceProviderType getServiceProvider(String s) {
    switch (s) {
      case "Electronic":
        return ServiceProviderType.electronic;
      case "Delivery":
        return ServiceProviderType.delivery;
      case "Home Cleaning":
        return ServiceProviderType.homeCleaning;
      case "House Moving":
        return ServiceProviderType.houseMoving;
      case "Laundry":
        return ServiceProviderType.laundry;
      default:
        return ServiceProviderType.electronic;
    }
  }
}
