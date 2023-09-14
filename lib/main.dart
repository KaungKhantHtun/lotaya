import 'package:flutter/material.dart';
import 'package:hakathon_service/presentation/cubit/booking_cubit.dart';
import 'package:hakathon_service/presentation/pages/booking/bookings_screen.dart';
import 'presentation/pages/home/home_screen.dart';
import 'presentation/pages/onboarding/onboarding_screen.dart';
import 'services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService().init();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      theme:
          ThemeData(primarySwatch: Colors.blue, textTheme: const TextTheme()),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: ElectronicServiceScreen(
      //   serviceProvider: serviceProviderEntity,
      // ),
      // home: const HomeScreen(
      //   initialIndex: 0,
      // ),
      //home: const KiloTaxiScreen(),
      // home: BlocProvider(
      //   create: (_) => BookingCubit(),
      //   child: BookingsScreen(),
      //   ),
      
      
      // home: CleaningServiceScreen(
      //   serviceProvider: serviceProviderEntity,
      // ),
      // home: const HomeScreen(
      //   initialIndex: 0,
      // ),
      home:OnboardingScreen(),
      // home: FreelancerScreen(),
    );
  }
}
