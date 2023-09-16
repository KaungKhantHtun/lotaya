import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:hakathon_service/domain/entities/cloth_entity.dart';
import 'package:hakathon_service/domain/entities/freelancer_entity.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/domain/entities/wear_type.dart';

import '../domain/entities/service_provider_entity.dart';

const String bookingTable = "booking";
const String roomTable = "rooms";
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
    serviceName: "Global Electronics Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "We pride ourselves on our dedication to customer satisfaction. Your needs are at the heart of everything we do, and we work tirelessly to deliver efficient, cost-effective, and reliable solutions that exceed your expectations.",
    priceRate: 10000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address:
        "No. 8, Anada Gone Ye St., Myittar Nyunt Qty., Tamwe Township, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "2",
    serviceName: "San Electronics Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "Our team of highly skilled technicians and engineers brings a wealth of knowledge and expertise to every project. Whether it's repairing your favorite gadgets, optimizing your home automation system, or designing custom electronic solutions for your business, we have the skills and experience to get the job done right.",
    priceRate: 10000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No.8,  Lay Dauk Kan Street, Thingangyun Township, Yangon",
  ),
  ServiceProviderEntity(
    serviceId: "3",
    serviceName: "Mon Htay  Electronics Service",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "At Mon Htay, we are your trusted partner for all your electronics service needs. With a passion for innovation and a commitment to excellence, we have been serving customers like you since 2000 Year. ",
    priceRate: 10000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No. 9,  9 Miles, Mayangone Township, Yangon/9765403250 ",
  ),
  ServiceProviderEntity(
    serviceId: "4",
    serviceName: "Khant Khant Gyee",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "When you choose Khant Khant Gyee, you're choosing a partner who understands the intricacies of electronics and is committed to delivering top-notch service. We look forward to serving you and helping you make the most of your electronic devices and systems., we have been serving customers like you since 2000 Year. ",
    priceRate: 10000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address:
        "No.99, 3B, Shu Khin Thar Road, TharKayTa Township, Yangon  9420265999",
  ),
  ServiceProviderEntity(
    serviceId: "5",
    serviceName: "Zin Htun and Sons",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "What sets us apart is our unwavering commitment to customer satisfaction. We believe in open communication, transparency, and building long-lasting relationships with our clients. We take the time to understand your goals and work collaboratively to achieve them.",
    priceRate: 10000,
    serviceType: ServiceProviderType.electronic,
    rating: 5,
    address: "No 37, Yadanartheinkha Street, Kyun Taw Road  /9401531039 ",
  ),
];
final List<ServiceProviderEntity> laundryList = [
  ServiceProviderEntity(
    serviceId: "1",
    serviceName: "Fresh Clean Laundry Hub",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "At Fresh Clean Laundry Hub, we understand that life can get busy, and laundry can be a daunting chore. That's where we step in. Our commitment to excellence is unwavering, and we take pride in delivering laundry services that meet and exceed your expectations. ",
    priceRate: 10000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address:
        "Thumeiktar (25)st, 1 Wards,North Okkalapa Township,Yangon / 9401598081  ",
  ),
  ServiceProviderEntity(
    serviceId: "2",
    serviceName: "LaundryEase ",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "We know your time is valuable. That's why we've designed our services to be as convenient as possible. With easy online booking, flexible pickup and delivery options, and quick turnaround times, we aim to make laundry day a breeze for you.",
    priceRate: 10000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address: "No. 98, Thida Street, Kyimyindine Township, 09421095161  ",
  ),
  ServiceProviderEntity(
    serviceId: "3",
    serviceName: "LaundryLux",
    imgUrl: "assets/aircon_service.jpg",
    about:
        "When you choose LaundryLux, you become part of our growing community of satisfied customers. Your trust is our most valued asset, and we are committed to earning it every day.",
    priceRate: 10000,
    serviceType: ServiceProviderType.laundry,
    rating: 5,
    address: "No. 9, Dana Street, Yankin Township, Yangon   ",
  ),
  ServiceProviderEntity(
      serviceId: "4",
      serviceName: "LaundryCare Express",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "Welcome to LaundryCare Express, your trusted partner in laundry solutions. Since 2000, we've been on a mission to redefine the way you experience laundry, making it effortless, convenient, and refreshingly hassle-free. ",
      priceRate: 10000,
      serviceType: ServiceProviderType.laundry,
      rating: 5,
      address: "No. 90, Mingalar Street, Sanchaung Township, Yangon"),
  ServiceProviderEntity(
      serviceId: "5",
      serviceName: "PurePress Laundry Services",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "Thank you for choosing PurePress Laundry Services as your laundry partner. We look forward to serving you with the care and dedication you deserve.",
      priceRate: 10000,
      serviceType: ServiceProviderType.laundry,
      rating: 5,
      address: "No.01, Hledan Street, Lamadaw Township, Yangon"),
];
final List<ServiceProviderEntity> homeCleaningList = [
  ServiceProviderEntity(
      serviceId: "1",
      serviceName: "Fortune Cleasing Services",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "At fortune cleasing services , we are dedicated to transforming spaces into pristine havens of cleanliness and hygiene. With a commitment to excellence, unwavering professionalism, and a passion for impeccable sanitation, we have emerged as a trusted name in the industry.",
      priceRate: 15000,
      serviceType: ServiceProviderType.homeCleaning,
      rating: 5,
      address:
          "no.(112A), baho road, kauktada township, yangon ,09-96626788210"),
  ServiceProviderEntity(
      serviceId: "2",
      serviceName: "Flexible  cleasing services ",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "Welcome to Flexible  cleasing services, your trusted partner in creating immaculate spaces. With a focus on hygiene, innovation, and a commitment to customer satisfaction, we have been setting the standard for cleanliness in Your Location and beyond",
      priceRate: 15000,
      serviceType: ServiceProviderType.homeCleaning,
      rating: 5,
      address: "no.(64B) , pazundaung  township , yangon ,09-76547333"),
  ServiceProviderEntity(
      serviceId: "3",
      serviceName: "Phyu Sin Cleasing Services",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "At phyu sin cleasing services , we are driven by a profound commitment to cleanliness, health, and customer satisfaction. With years of experience and a dedicated team, we have become a trusted name in the cleansing services industry.",
      priceRate: 15000,
      serviceType: ServiceProviderType.homeCleaning,
      rating: 5,
      address: "no.(7B), insein road, kamaryut township, yangon, 09-440211789"),
  ServiceProviderEntity(
      serviceId: "4",
      serviceName: " Lucky cleasing services  ",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "At Lucky  cleasing services , we are driven by a profound commitment to cleanliness, health, and customer satisfaction. With years of experience and a dedicated team, we have become a trusted name in the cleansing services industry.",
      priceRate: 15000,
      serviceType: ServiceProviderType.homeCleaning,
      rating: 5,
      address: "no.(7B) ,Hlaing   township , yangon ,09-56780654"),
  ServiceProviderEntity(
      serviceId: "5",
      serviceName: "New Light Cleasing Services",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "Founded in 2005,  new light  was born out of a simple yet powerful vision: to create spaces that inspire well-being and comfort through the art of cleaning. What started as a small local enterprise has now grown into a company known for excellence.",
      priceRate: 15000,
      serviceType: ServiceProviderType.homeCleaning,
      rating: 5,
      address:
          "no 45, Anayathar Street ,pazundaung township , Yangon ,09-76090776"),
];
final List<ServiceProviderEntity> houseMovingList = [
  ServiceProviderEntity(
      serviceId: "1",
      serviceName: "MoveEase Solutions",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "At House moving services, we understand that moving can be one of life's most stressful experiences. That's why we're here to make it as smooth and hassle-free as possible. With years of experience, a dedicated team, and a passion for helping you transition to your new home, we've become a trusted partner in the moving industry.",
      priceRate: 25000,
      serviceType: ServiceProviderType.houseMoving,
      rating: 5,
      address:
          "No. 61, Hdu Par Yone Street, Insein Township, Yangon , Yangon /097653108"),
  ServiceProviderEntity(
      serviceId: "2",
      serviceName: "HomeTransit Solutions",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "Welcome to HomeTransit Solutions, where our passion for  meets unwavering dedication to customer satisfaction. With a rich history of excellence, a team of skilled professionals, and a commitment to innovation, we are proud to be your trusted partner",
      priceRate: 25000,
      serviceType: ServiceProviderType.houseMoving,
      rating: 5,
      address:
          "no.118(A), u htun lin street , kamaryut township , Yangon /0966778899"),
  ServiceProviderEntity(
      serviceId: "3",
      serviceName: "MoveMaster Services",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "Welcome to MoveMaster Services, a beacon of excellence in . With a history rooted in passion, a commitment to unwavering quality, and a vision for [mention your mission or vision, e.g., \"a brighter, more sustainable future\"], we are proud to be your trusted partner.",
      priceRate: 25000,
      serviceType: ServiceProviderType.houseMoving,
      rating: 5,
      address: "Danar Yone Quarter, Sagaing City, Mandalay/094440889"),
  ServiceProviderEntity(
      serviceId: "4",
      serviceName: "Global Moving services ",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "At Global Moving Services ,  we take immense pride in our work and are eager to serve you with dedication, integrity, and a commitment to making your move a breeze. Contact us today to experience the difference in your next home transition.",
      priceRate: 25000,
      serviceType: ServiceProviderType.houseMoving,
      rating: 5,
      address: "No.10, 8 mile, Mayangon Township, Yangon/09778886790 "),
  ServiceProviderEntity(
      serviceId: "5",
      serviceName: "Change U Moving Services",
      imgUrl: "assets/aircon_service.jpg",
      about:
          "Welcome to Moving Services, your trusted partner in making moving house a breeze. With a history steeped in reliability, a dedicated team of professionals, and a commitment to turning your relocation into a stress-free experience, we take pride in being the go-to choice for all your home moving needs.",
      priceRate: 25000,
      serviceType: ServiceProviderType.houseMoving,
      rating: 5,
      address:
          "No. 61, Hdu Par Yone Street, Insein Township, Yangon/0978654321 "),
];
final Map<ServiceProviderType, List<ServiceProviderEntity>> serviceProviderMap =
    {
  ServiceProviderType.electronic: electronicList,
  ServiceProviderType.laundry: laundryList,
  ServiceProviderType.homeCleaning: homeCleaningList,
  ServiceProviderType.houseMoving: houseMovingList
};

final List<FreelancerEntity> psychologistList = [
  FreelancerEntity(
    type: FreelancerType.psychologist,
    imgUrl: "imageUrl",
    name: "Dr.Emily Smith",
    hourlyRate: 5000,
    location: "Yangon",
    bio:
        "Licensed Professional Counsellor,  Sensorimotor Psychotherapist.\n Life can be challenging at times. I am prepared to assist you in transforming the challenges you might be facing into opportunities for self enhancement and personal growth. I am passionate about bringing your best you to surface, in a compassionate and efficient way.",
    age: 30,
    phoneNumber: "09753421",
  ),
  FreelancerEntity(
    type: FreelancerType.psychologist,
    imgUrl: "imageUrl",
    name: "Dr.Benjamin Johnson",
    hourlyRate: 5000,
    location: "Yangon",
    bio: "Licensed Professional Counsellor,  Sensorimotor Psychotherapist.",
    age: 30,
    phoneNumber: "0942299309",
  ),
  FreelancerEntity(
    type: FreelancerType.psychologist,
    imgUrl: "imageUrl",
    name: "Dr.Sarah Williams",
    hourlyRate: 5000,
    location: "Yangon",
    bio:
        "An educational psychologist based in Johannesburg working with children and adolescents from the ages of 4 until 18 years old.",
    age: 25,
    phoneNumber: "097842211",
  ),
];

final List<FreelancerEntity> babySitterList = [
  FreelancerEntity(
    type: FreelancerType.babySitter,
    imgUrl: "imageUrl",
    name: "Pyae Pyae",
    hourlyRate: 5000,
    location: "Yangon",
    bio:
        "Hello, parents! It's Me, your friendly neighborhood babysitter. I've been providing trusted childcare services for 10 years",
    age: 30,
    phoneNumber: "09753421",
  ),
  FreelancerEntity(
    type: FreelancerType.babySitter,
    imgUrl: "imageUrl",
    name: "Kyaw Kyaw",
    hourlyRate: 5000,
    location: "Yangon",
    bio:
        "Greetings! It's Me, your reliable and caring babysitter. With a background in early childhood education and 5  years of hands-on experience",
    age: 30,
    phoneNumber: "0942299309",
  ),
  FreelancerEntity(
    type: FreelancerType.babySitter,
    imgUrl: "imageUrl",
    name: "Zin Mar",
    hourlyRate: 5000,
    location: "Yangon",
    bio:
        "Hey there, families! It's Me , an experienced babysitter with a heart full of love for kids. With 8 years of childcare experience.",
    age: 25,
    phoneNumber: "097842211",
  ),
];

final List<FreelancerEntity> coachList = [
  FreelancerEntity(
      type: FreelancerType.coach,
      imgUrl: "imageUrl",
      name: "Liam",
      hourlyRate: 2,
      location: "Yangon",
      bio:
          "Hi, It's Me, a dedicated life coach on a mission to help you unlock your full potential and achieve your dreams. ",
      age: 28,
      phoneNumber: "0977889900"),
  FreelancerEntity(
      type: FreelancerType.coach,
      imgUrl: "imageUrl",
      name: "Leo",
      hourlyRate: 2,
      location: "Yangon",
      bio:
          "Welcome! It's Me, a certified fitness coach with a passion for health and well-being",
      age: 25,
      phoneNumber: "0977619900"),
  FreelancerEntity(
      type: FreelancerType.coach,
      imgUrl: "imageUrl",
      name: "Suzy ",
      hourlyRate: 2,
      location: "Yangon",
      bio:
          "Greetings! It's Me , a seasoned business coach committed to helping entrepreneurs and small businesses thrive. ",
      age: 30,
      phoneNumber: "09432100789"),
];
final List<FreelancerEntity> dogWalkerList = [
  FreelancerEntity(
      type: FreelancerType.dogWalker,
      imgUrl: "imageUrl",
      name: "Jame",
      hourlyRate: 10000,
      location: "Yangon",
      bio:
          "Good day, doggie friends! It's Me , an experienced dog walker with a passion for outdoor adventures. ",
      age: 30,
      phoneNumber: "0945566789"),
  FreelancerEntity(
      type: FreelancerType.dogWalker,
      imgUrl: "imageUrl",
      name: "John",
      hourlyRate: 10000,
      location: "Manadalay",
      bio:
          "Hey there, pet parents! It's Me , your reliable dog walker with 5 years experenice. ",
      age: 30,
      phoneNumber: " 09667555678 "),
  FreelancerEntity(
      type: FreelancerType.dogWalker,
      imgUrl: "imageUrl",
      name: "Su Su ",
      hourlyRate: 10000,
      location: "Manadalay",
      bio:
          "Greetings, dog lovers! It's Me , a certified dog walker with a passion for pups and a commitment to their well-being. ",
      age: 30,
      phoneNumber: " 097865310"),
];
final List<FreelancerEntity> gardenerList = [
  FreelancerEntity(
    type: FreelancerType.gardener,
    imgUrl: "imageUrl",
    name: "Myat ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "Hello, green thumbs! It's Me , a passionate gardener with 5  years of experience nurturing nature's beauty.",
    age: 30,
    phoneNumber: "09440789061",
  ),
  FreelancerEntity(
    type: FreelancerType.gardener,
    imgUrl: "imageUrl",
    name: "Thazin ",
    hourlyRate: 10000,
    location: "Yangon",
    bio: "Hey there, garden lovers! It's Me , your dedicated gardener.",
    age: 25,
    phoneNumber: " 09449876345",
  ),
  FreelancerEntity(
    type: FreelancerType.gardener,
    imgUrl: "imageUrl",
    name: "Aung  ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "G'day, fellow gardeners! It's Me , an avid horticulturist with a knack for turning soil into art. ",
    age: 25,
    phoneNumber: " 09443421789",
  ),
];

//TODO
final List<FreelancerEntity> driverList = [
  FreelancerEntity(
    type: FreelancerType.driver,
    imgUrl: "imageUrl",
    name: "Myat ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "Hello, green thumbs! It's Me , a passionate gardener with 5  years of experience nurturing nature's beauty.",
    age: 30,
    phoneNumber: "09440789061",
  ),
  FreelancerEntity(
    type: FreelancerType.driver,
    imgUrl: "imageUrl",
    name: "Thazin ",
    hourlyRate: 10000,
    location: "Yangon",
    bio: "Hey there, garden lovers! It's Me , your dedicated gardener.",
    age: 25,
    phoneNumber: " 09449876345",
  ),
  FreelancerEntity(
    type: FreelancerType.driver,
    imgUrl: "imageUrl",
    name: "Aung  ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "G'day, fellow gardeners! It's Me , an avid horticulturist with a knack for turning soil into art. ",
    age: 25,
    phoneNumber: " 09443421789",
  ),
];

final List<FreelancerEntity> tutorList = [
  FreelancerEntity(
    type: FreelancerType.tutor,
    imgUrl: "imageUrl",
    name: "Myat ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "Hello, green thumbs! It's Me , a passionate gardener with 5  years of experience nurturing nature's beauty.",
    age: 30,
    phoneNumber: "09440789061",
  ),
  FreelancerEntity(
    type: FreelancerType.tutor,
    imgUrl: "imageUrl",
    name: "Thazin ",
    hourlyRate: 10000,
    location: "Yangon",
    bio: "Hey there, garden lovers!, It's Me , Your dedicated gardener.",
    age: 25,
    phoneNumber: " 09449876345",
  ),
  FreelancerEntity(
    type: FreelancerType.tutor,
    imgUrl: "imageUrl",
    name: "Aung  ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "G'day, fellow gardeners! It's Me , an avid horticulturist with a knack for turning soil into art. ",
    age: 25,
    phoneNumber: " 09443421789",
  ),
];
final List<FreelancerEntity> hairStylistList = [
  FreelancerEntity(
    type: FreelancerType.hairStylist,
    imgUrl: "imageUrl",
    name: "Myat ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "Hello, green thumbs! It's Me , a passionate gardener with 5  years of experience nurturing nature's beauty.",
    age: 30,
    phoneNumber: "09440789061",
  ),
  FreelancerEntity(
    type: FreelancerType.hairStylist,
    imgUrl: "imageUrl",
    name: "Thazin ",
    hourlyRate: 10000,
    location: "Yangon",
    bio: "Hey there, garden lovers! It's Me , your dedicated gardener.",
    age: 25,
    phoneNumber: " 09449876345",
  ),
  FreelancerEntity(
    type: FreelancerType.hairStylist,
    imgUrl: "imageUrl",
    name: "Aung  ",
    hourlyRate: 10000,
    location: "Yangon",
    bio:
        "G'day, fellow gardeners! It's Me , an avid horticulturist with a knack for turning soil into art. ",
    age: 25,
    phoneNumber: " 09443421789",
  ),
];
final List<Map<String, String>> termsAndConditonList = [
  {
    "1. Acceptance of Terms":
        "By using [Your Mobile Money App], you agree to follow these Terms and Conditions of Service. If you don't agree, please do not use the app.",
  },
  {
    "2. Eligibility":
        "You must be at least [age] years old to use the app. By using it, you confirm that you meet this requirement.",
  },
  {
    "3. Privacy":
        "Your use of the app is subject to our Privacy Policy, which you can find at [Link to Privacy Policy]. It explains how we handle your data.",
  },
  {
    "4. Account Responsibility":
        "If you create an account, you're responsible for safeguarding your login information. Please keep it secure.",
  },
  {
    "5. App Usage":
        "(a) You may use the app for personal purposes only, not for anything illegal or unauthorized.\n(b) Don't share your login info, and don't try to hack the app.",
  },
  {
    "6. User Content":
        "(a) You own your content but grant us permission to use it within the app.\n(b) You're responsible for your content.",
  },
  {
    "7. Termination":
        "We can suspend or terminate your access to the app at our discretion.",
  },
  {
    "8. Updates": "We may update or change the app without notice.",
  },
  {
    "9. Disclaimer":
        "The app is provided as-is, and we can't guarantee it's always error-free.",
  },
  {
    "10. Limitation of Liability":
        "We're not liable for any indirect, incidental, or consequential damages.",
  },
  {
    "11. Governing Law": "These terms are governed by the laws of government.",
  }
];
