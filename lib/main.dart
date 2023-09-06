import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/service_provider_entity.dart';
import 'package:hakathon_service/presentation/pages/chat_screen.dart';
import 'package:hakathon_service/presentation/pages/dashboard_screen.dart';

import 'domain/entities/service_provider_type.dart';
import 'presentation/pages/bookings_screen.dart';
import 'presentation/pages/electronic_service/electronic_service_screen.dart';
import 'presentation/pages/profile_screen.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseService().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  ServiceProviderEntity serviceProviderEntity = ServiceProviderEntity(
      serviceName: "Home Appliance Repair",
      about: "We offer professional reparing service on-demand",
      priceRate: 5000,
      serviceType: ServiceProviderType.electronic,
      rating: 5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, textTheme: const TextTheme()),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: ElectronicServiceScreen(
        serviceProvider: serviceProviderEntity,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  List<Widget> widgetList = [];

  @override
  void initState() {
    widgetList = const [
      DashboardScreen(),
      BookingsScreen(),
      ChatScreen(),
      ProfileScreen()
    ];
    super.initState();
  }

  void selectedPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          selectedPage(index);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xff9F9F9F),
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        unselectedIconTheme: const IconThemeData(color: Color(0xff9F9F9F)),
        unselectedLabelStyle: const TextStyle(),
        selectedLabelStyle: const TextStyle(),
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Bookings",
            icon: Icon(Icons.book_online),
          ),
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
