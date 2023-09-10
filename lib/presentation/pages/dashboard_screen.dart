import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/service_provider_entity.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/presentation/pages/electronic_service/electronic_service_screen.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/booking_entity.dart';
import '../../utils/constants.dart';
import 'booking/booking_detail_screen.dart';
import 'categories_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Query<Map<String, dynamic>> querySnapshot;

  @override
  void initState() {
    querySnapshot = FirebaseFirestore.instance
        .collection(bookingTable)
        .where('bookingStatus', whereIn: [
          BookingStatus.pending.name,
          BookingStatus.pendingPayment.name,
          BookingStatus.requested.name,
        ])
        .orderBy('bookingCreatedTime')
        .limit(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/clean.png",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              height: 120,
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
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Our Services",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ElectronicServiceScreen(
                                      serviceProvider: serviceProviderEntity,
                                    )));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    "assets/aircon_service.jpg",
                                    fit: BoxFit.fitHeight,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                const Text(
                                  "Aircon Service",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    "assets/laundry_service.jpg",
                                    fit: BoxFit.fitHeight,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                const Text(
                                  "Laundry Service",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    "assets/clean_service.jpg",
                                    fit: BoxFit.fitHeight,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                const Text(
                                  "Home Clean Service",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              getTestData();
                            },
                            child: const Text("Test"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ServiceProviderEntity serviceProviderEntity = ServiceProviderEntity(
      serviceId: "1",
      serviceName: "Home Appliance Repair",
      about: "We offer professional reparing service on-demand",
      priceRate: 5000,
      serviceType: ServiceProviderType.electronic,
      rating: 5);

  Future<void> getTestData() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection(testTable);

    try {
      QuerySnapshot querySnapshot = await users.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        print(doc.data());
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }
}
