import 'package:flutter/material.dart';
import 'package:hakathon_service/utils/constants.dart';

import '../../../services/user_profile_service.dart';
import '../booking/bookings_screen.dart';
import '../chat_screen.dart';
import '../dashboard_screen.dart';
import '../profile/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> widgetList = [];

  @override
  void initState() {
    operateUser();
    widgetList = const [
      DashboardScreen(),
      BookingsScreen(),
      ChatListScreen(),
      SettingScreen()
    ];
    currentIndex = widget.initialIndex;
    super.initState();
  }

  operateUser() async {
    await UserProfileService().operateUserProfile();
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
        selectedItemColor: colorPrimary,
        unselectedItemColor: const Color(0xff9F9F9F),
        selectedIconTheme: const IconThemeData(
          color: colorPrimary,
        ),
        unselectedIconTheme: const IconThemeData(color: Color(0xff9F9F9F)),
        unselectedLabelStyle: const TextStyle(),
        selectedLabelStyle: const TextStyle(),
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: [
          const BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Bookings",
            icon: Image.asset(
              "assets/booking.png",
              width: 20,
              height: 20,
              color: currentIndex == 1 ? colorPrimary : const Color(0xff9F9F9F),
            ),
          ),
          const BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(Icons.chat),
          ),
          const BottomNavigationBarItem(
            label: "Setting",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
