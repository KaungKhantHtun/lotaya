import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:hakathon_service/domain/entities/cloth_entity.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/domain/entities/wear_type.dart';

import '../domain/entities/service_provider_entity.dart';

const String bookingTable = "booking";
const String profileTable = "profile";
const Color colorPrimary = Color(0xff1f467d);
const Color colorPrimaryLight = Color(0xFFE6F0FD);
const Color headerSectionColor = Color(0xfff0ffff);
const Color colorSecondary = Color(0xffffba00);
const Color colorSecondaryVariant = Color(0xfff9f3e8);
const Color colorGrey = Color(0xfff7f8fa);
const Color fontColorGrey = Color(0xffadb4b6);
const Color errorColor = Color(0xFFC40C0C);
const Color successColor = Color(0xFF219F02);
Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

const TextStyle headerStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

const TextStyle regularStyle = TextStyle(
  fontSize: 13,
  // fontWeight: FontWeight.w600,
);

const String mapApiKey = "AIzaSyBcQNwTBaKpuGRkJWDCytVvG0v7nqZRrwc";
List<ClothEntity> clothList = [
  ClothEntity(
      id: "c1",
      name: "Top",
      imgUrl: "assets/clothes/top.png",
      wearType: WearType.clothes,
      dryCleanPrice: 250,
      washAndIconPrice: 200,
      ironPrice: 100),
  ClothEntity(
      id: "c2",
      name: "Jeans",
      imgUrl: "assets/clothes/jeans.png",
      wearType: WearType.clothes,
      dryCleanPrice: 250,
      washAndIconPrice: 250,
      ironPrice: 100),
  ClothEntity(
      id: "c3",
      name: "Dress",
      imgUrl: "assets/clothes/dress.png",
      wearType: WearType.clothes,
      dryCleanPrice: 250,
      washAndIconPrice: 250,
      ironPrice: 100),
  ClothEntity(
      id: "c4",
      name: "Trousers",
      imgUrl: "assets/clothes/trousers.png",
      wearType: WearType.clothes,
      dryCleanPrice: 250,
      washAndIconPrice: 250,
      ironPrice: 200),
  ClothEntity(
      id: "c5",
      name: "Child Cloth",
      imgUrl: "assets/clothes/child.png",
      wearType: WearType.clothes,
      dryCleanPrice: 150,
      washAndIconPrice: 150,
      ironPrice: 100),
];
List<ClothEntity> outWearList = [
  ClothEntity(
      id: "outer1",
      name: "Hoodie",
      imgUrl: "assets/clothes/hoodie.png",
      wearType: WearType.clothes,
      dryCleanPrice: 500,
      washAndIconPrice: 500,
      ironPrice: 100),
  ClothEntity(
      id: "outer2",
      name: "Blazer",
      imgUrl: "assets/clothes/blazer.png",
      wearType: WearType.clothes,
      dryCleanPrice: 500,
      washAndIconPrice: 500,
      ironPrice: 100),
  ClothEntity(
      id: "outer3",
      name: "Coat",
      imgUrl: "assets/clothes/coat.png",
      wearType: WearType.clothes,
      dryCleanPrice: 500,
      washAndIconPrice: 500,
      ironPrice: 100),
  ClothEntity(
      id: "outer4",
      name: "Sweater",
      imgUrl: "assets/clothes/sweater.png",
      wearType: WearType.clothes,
      dryCleanPrice: 500,
      washAndIconPrice: 500,
      ironPrice: 100),
  ClothEntity(
      id: "outer5",
      name: "Leather",
      imgUrl: "assets/clothes/leather-jacket.png",
      wearType: WearType.clothes,
      dryCleanPrice: 1000,
      washAndIconPrice: 500,
      ironPrice: 200),
  ClothEntity(
      id: "outer6",
      name: "Jacket",
      imgUrl: "assets/clothes/jacket.png",
      wearType: WearType.clothes,
      dryCleanPrice: 700,
      washAndIconPrice: 500,
      ironPrice: 200),
];

List<ClothEntity> homeAccessoriesList = [
  ClothEntity(
      id: "h1",
      name: "Bed Sheets",
      imgUrl: "assets/clothes/bed-sheets.png",
      wearType: WearType.homeAccessories,
      dryCleanPrice: 1200,
      washAndIconPrice: 1200,
      ironPrice: 200),
  ClothEntity(
      id: "h2",
      name: "Pillows",
      imgUrl: "assets/clothes/pillows.png",
      wearType: WearType.homeAccessories,
      dryCleanPrice: 700,
      washAndIconPrice: 700,
      ironPrice: 200),
  ClothEntity(
      id: "h3",
      name: "Mattress",
      imgUrl: "assets/clothes/mattress.png",
      wearType: WearType.homeAccessories,
      dryCleanPrice: 3000,
      washAndIconPrice: 3000,
      ironPrice: 200),
  ClothEntity(
      id: "h4",
      name: "Sofa",
      imgUrl: "assets/clothes/sofa.png",
      wearType: WearType.homeAccessories,
      dryCleanPrice: 3000,
      washAndIconPrice: 3000,
      ironPrice: 200),
  ClothEntity(
      id: "h5",
      name: "Carpet",
      imgUrl: "assets/clothes/carpet.png",
      wearType: WearType.homeAccessories,
      dryCleanPrice: 3000,
      washAndIconPrice: 3000,
      ironPrice: 200),
];
List<ClothEntity> othersList = [
  ClothEntity(
      id: "j1",
      name: "Shoes",
      imgUrl: "assets/clothes/shoes.png",
      wearType: WearType.others,
      dryCleanPrice: 700,
      washAndIconPrice: 700,
      ironPrice: 200),
  ClothEntity(
      id: "j2",
      name: "Travel Bag",
      imgUrl: "assets/clothes/travel-bag.png",
      wearType: WearType.others,
      dryCleanPrice: 3500,
      washAndIconPrice: 3000,
      ironPrice: 200),
  ClothEntity(
      id: "j3",
      name: "School Bag",
      imgUrl: "assets/clothes/school-bag.png",
      wearType: WearType.others,
      dryCleanPrice: 1500,
      washAndIconPrice: 1500,
      ironPrice: 200),
];

final List<ClothEntity> originalClothList = [
  ...clothList,
  ...outWearList,
  ...homeAccessoriesList,
  ...othersList,
];

const currentUser = User(
  id: "W1",
  firstName: "First Name",
  lastName: "Last Name",
  imageUrl: "",
);

const adminUser = User(
  id: "Admin1",
  firstName: "Admin First Name",
  lastName: "Admin Last Name",
  imageUrl: "",
);

bool isAdmin = false;
final List<ServiceProviderEntity> electronicList = [
  ServiceProviderEntity(
    serviceId: "1",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "2",
    serviceName: "Trane Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Trane is another reputable HVAC company that provides air conditioning services. They offer a range of cooling solutions, from central air conditioning systems to ductless mini-split units. Trane's services include installation, maintenance, and 24/7 emergency repairs.",
    priceRate: 5000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "3",
    serviceName: "Lennox Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Lennox offers air conditioning services and is known for its high-quality cooling products. They provide installation services for their air conditioning systems, as well as regular maintenance to keep systems running efficiently. Lennox also offers energy-efficient options for environmentally conscious customers.",
    priceRate: 5000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "4",
    serviceName: "Daikin Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Daikin is a global leader in HVAC technology and offers comprehensive air conditioning services. They provide installation of Daikin cooling systems, which include air conditioners and heat pumps. Daikin's services also cover maintenance and repairs to ensure optimal performance.",
    priceRate: 5000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "5",
    serviceName: "Local HVAC Contractor",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Many local HVAC contractors offer air conditioning services tailored to the needs of their specific region. These contractors provide services such as installation, seasonal maintenance, and emergency repairs for a wide range of air conditioning systems. Choosing a reputable local HVAC contractor can ensure personalized service and quick response times.",
    priceRate: 5000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
];
final List<ServiceProviderEntity> laundryList = [
  ServiceProviderEntity(
    serviceId: "1",
    serviceName: "Tide Cleaners",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Tide Cleaners is a well-known laundry service chain that offers professional dry cleaning and laundry services. They provide convenient drop-off and pickup locations, including standalone stores and kiosks in various cities. Tide Cleaners is known for its quality cleaning and fast turnaround times.",
    priceRate: 5000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "2",
    serviceName: "Cool Clean",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "3",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "4",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "5",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
];
final List<ServiceProviderEntity> homeCleaningList = [
  ServiceProviderEntity(
    serviceId: "1",
    serviceName: "Tide Cleaners",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Tide Cleaners is a well-known homeCleaning service chain that offers professional dry cleaning and homeCleaning services. They provide convenient drop-off and pickup locations, including standalone stores and kiosks in various cities. Tide Cleaners is known for its quality cleaning and fast turnaround times.",
    priceRate: 5000,
    serviceType: ServiceProviderType.homeCleaning,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "2",
    serviceName: "Cool Clean",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.homeCleaning,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "3",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.homeCleaning,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "4",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.homeCleaning,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "5",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.homeCleaning,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
];
final List<ServiceProviderEntity> houseMovingList = [
  ServiceProviderEntity(
    serviceId: "1",
    serviceName: "Tide Cleaners",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Tide Cleaners is a well-known houseMoving service chain that offers professional dry cleaning and houseMoving services. They provide convenient drop-off and pickup locations, including standalone stores and kiosks in various cities. Tide Cleaners is known for its quality cleaning and fast turnaround times.",
    priceRate: 5000,
    serviceType: ServiceProviderType.houseMoving,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "2",
    serviceName: "Cool Clean",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.houseMoving,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "3",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.houseMoving,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "4",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.houseMoving,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "5",
    serviceName: "Carrier Air Conditioning Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Carrier is a renowned company in the HVAC (Heating, Ventilation, and Air Conditioning) industry. They offer air conditioning services, including installation, maintenance, and repairs for residential and commercial customers. Carrier is known for its innovative cooling solutions and energy-efficient systems.",
    priceRate: 5000,
    serviceType: ServiceProviderType.houseMoving,
    rating: 5,
    address: "No. 123, Pyay road, Yangon",
  ),
];

final Map<ServiceProviderType, List<ServiceProviderEntity>> serviceProviderMap =
    {
  ServiceProviderType.electronic: electronicList,
  ServiceProviderType.laundry: laundryList,
  ServiceProviderType.homeCleaning: homeCleaningList,
  ServiceProviderType.houseMoving: houseMovingList
};
