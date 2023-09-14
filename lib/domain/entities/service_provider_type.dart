enum ServiceProviderType {
  electronic(
    "Electronic",
    "assets/aircon.png",
  ),
  delivery(
    "Delivery",
    "assets/house-keeping.png",
  ),
  homeCleaning(
    "Home Cleaning",
    "assets/house-keeping.png",
  ),
  houseMoving(
    "House Moving",
    "assets/moving-truck.png",
  ),
  laundry(
    "Laundry",
    "assets/laundry-machine.png",
  ),
  kiloTaxi(
    "Kilo Taxi",
    "assets/taxi 2.png",
  ),
  freelancer(
    "Freelancer",
    "assets/time-management.png",
  );

  final String name;
  final String imgUrl;
  const ServiceProviderType(this.name, this.imgUrl);
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
