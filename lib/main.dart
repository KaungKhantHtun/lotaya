import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/service_provider_entity.dart';
import 'package:hakathon_service/presentation/cubit/booking_cubit.dart';
import 'package:hakathon_service/presentation/pages/booking/bookings_screen.dart';

import 'domain/entities/service_provider_type.dart';
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

  ServiceProviderEntity serviceProviderEntity = ServiceProviderEntity(
      serviceId: "1",
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
      // home: ElectronicServiceScreen(
      //   serviceProvider: serviceProviderEntity,
      // ),
      // home: const HomeScreen(
      //   initialIndex: 0,
      // ),
      //home: const KiloTaxiScreen(),
      home: BlocProvider(
        create: (_) => BookingCubit(),
        child: BookingsScreen(),
        ),
      
      
      // home: CleaningServiceScreen(
      //   serviceProvider: serviceProviderEntity,
      // ),
      // home: const HomeScreen(
      //   initialIndex: 0,
      // ),
      // home: FreelancerScreen(),
    );
  }
}
