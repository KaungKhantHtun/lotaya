enum ServiceProviderType {
  electronic("Electronic"),
  delivery("Delivery"),
  homeCleaning(
    "Home Cleaning",
  ),
  houseMoving("House Moving"),
  laundry("Laundry"),
  kiloTaxi("Kilo Taxi"),
  freelancer("Freelancer");

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
          case "Kilo Taxi":
        return ServiceProviderType.kiloTaxi;
          case "Freelancer":
        return ServiceProviderType.freelancer;
      default:
        return ServiceProviderType.electronic;
    }
  }
}
