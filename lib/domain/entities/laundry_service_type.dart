enum LaundryServiceType {
  dryCleaning("Dry Cleaning"),
  washAndIron("Wash & Iron"),
  iron("Iron");

  final String name;
  const LaundryServiceType(this.name);
  static LaundryServiceType getLaundryServiceType(String value) {
    switch (value) {
      case "Dry Cleaning":
        return LaundryServiceType.dryCleaning;
      case "Wash & Iron":
        return LaundryServiceType.washAndIron;
      case "Iron":
      default:
        return LaundryServiceType.iron;
    }
  }
}
