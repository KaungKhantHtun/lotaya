import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakathon_service/bridge/system/system_interface.dart';
import 'package:hakathon_service/bridge/system/system_web_impl.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/presentation/pages/cleaning_service/cleaning_service_screen.dart';
import 'package:hakathon_service/presentation/pages/electronic_service/electronic_service_screen.dart';
import 'package:hakathon_service/presentation/pages/freelancer/freelancer_list_screen.dart';
import 'package:hakathon_service/presentation/pages/freelancer/freelancer_screen.dart';
import 'package:hakathon_service/presentation/pages/kilo_taxi/kilo_taxi_screen.dart';
import 'package:hakathon_service/presentation/pages/laundry_service/laundry_service_screen.dart';
import 'package:hakathon_service/presentation/pages/profile/profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/booking_entity.dart';
import '../../utils/constants.dart';
import 'booking/booking_detail_screen.dart';
import 'house_moving_service/house_moving_service_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Query<Map<String, dynamic>> querySnapshot;

  final ISystemBridge _iSystemBridge = Get.put(const SystemBridgeImpl());

  @override
  void initState() {
    querySnapshot = FirebaseFirestore.instance
        .collection(bookingTable)
        .where('bookingStatus', whereIn: [
          BookingStatus.serviceRequested.name,
          BookingStatus.pendingPayment.name,
          // BookingStatus.requested.name,
        ])
        .orderBy('bookingCreatedTime')
        .limit(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _iSystemBridge.exist();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: colorPrimary,
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/logo.png",
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.asset(
                            "assets/lotaya.png",
                            height: 32,
                            width: 80,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              )),
                          child: const Icon(
                            Icons.account_circle_rounded,
                            color: colorPrimary,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*
                        StreamBuilder(
                          stream: querySnapshot.snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              final data = snapshot.data;
    
                              if (data?.docs.length == 0) {
                                return Container();
                              }
                              var doc = data?.docs[0];
                              BookingEntity e = BookingEntity.fromDoc(doc);
    
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => BookingDetailScreen(
                                            bookingId: e.bookingId,
                                          )));
                                },
                                child: Container(
                                  //height: 120,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colorPrimary,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 16,
                                                width: 2,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                "Your booking is ${e.bookingStatus.name}.",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.close,
                                                size: 16,
                                                color: colorPrimary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: const Icon(Icons.check_box,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                e.name,
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${DateFormat('d MMM, y').format(e.bookingCreatedTime)} ${DateFormat('h:mm a').format(e.serviceTime)}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      */
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "What service are you \nlooking for?",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        /*SizedBox(
                          //width: MediaQuery.of(context).size.width / 1.5,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide: BorderSide.none, // Remove border
                              ),
                              filled: true,
                              fillColor: colorPrimaryLight,
                              hintText: 'Search...',
                              prefixIcon: Icon(Icons.search),
                              prefixIconColor: colorPrimary,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                            ),
                          ),
                        ),*/
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Freelance Services",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeServiceItemWidget(
                              label: "Driver",
                              imgUrl: "assets/driver.png",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FreelancerListScreen(
                                        label: "Psychologist",
                                      ),
                                    ));
                              },
                            ),
                            HomeServiceItemWidget(
                              label: "Baby Sitter",
                              imgUrl: "assets/babysitter.png",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FreelancerListScreen(
                                        label: "Psychologist",
                                      ),
                                    ));
                              },
                            ),
                            HomeServiceItemWidget(
                              label: "Psychologist",
                              imgUrl: "assets/psychologist.png",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FreelancerListScreen(
                                        label: "Psychologist",
                                      ),
                                    ));
                              },
                            ),
                            HomeServiceItemWidget(
                              label: "More",
                              imgUrl: "assets/more.png",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FreelancerScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Company Services",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            HomeServiceItemWidget(
                              label: "Electronic\nServices",
                              imgUrl: "assets/electric.png",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ElectronicServiceScreen(),
                                  ),
                                );
                              },
                            ),
                            HomeServiceItemWidget(
                              label: "Laundry\nServices",
                              imgUrl: "assets/laundry-machine.png",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LaundryServiceScreen(),
                                  ),
                                );
                              },
                            ),
                            HomeServiceItemWidget(
                              label: "Cleaning\nServices",
                              imgUrl: "assets/house-keeping.png",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CleaningServiceScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeServiceItemWidget(
                              label: "House\nMoving",
                              imgUrl: "assets/moving-truck.png",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HouseMovingServiceScreen(),
                                  ),
                                );
                              },
                            ),
                            HomeServiceItemWidget(
                              label: "Kilo Taxi\nService",
                              imgUrl: "assets/taxi 2.png",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const KiloTaxiScreen(),
                                  ),
                                );
                              },
                            ),
                            HomeServiceItemWidget(
                              label: "Freelancer",
                              imgUrl: "assets/time-management.png",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FreelancerScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeServiceItemWidget extends StatelessWidget {
  const HomeServiceItemWidget({
    super.key,
    required this.onTap,
    required this.imgUrl,
    required this.label,
  });

  final Function() onTap;
  final String imgUrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 64,
              width: 64,
              decoration: const BoxDecoration(
                  color: colorPrimaryLight, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset(
                  imgUrl,
                  color: colorPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
