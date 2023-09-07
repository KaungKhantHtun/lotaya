import 'package:flutter/material.dart';

import '../booking/bookings_screen.dart';
import '../chat_screen.dart';
import '../dashboard_screen.dart';
import '../profile_screen.dart';

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
    widgetList = const [
      DashboardScreen(),
      BookingsScreen(),
      ChatScreen(),
      ProfileScreen()
    ];
    currentIndex = widget.initialIndex;
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
