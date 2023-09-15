import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/presentation/cubit/booking_cubit.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../widgets/stepper_widget.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({Key? key, required this.bookingId})
      : super(key: key);
  final String bookingId;

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  late Query<Map<String, dynamic>> querySnapshot;
  @override
  void initState() {
    querySnapshot = FirebaseFirestore.instance
        .collection(bookingTable)
        .where("bookingId", isEqualTo: widget.bookingId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: colorPrimary,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Booking Detail",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: querySnapshot.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            final data = snapshot.data;

            if (data?.docs.length == 0) {
              return Container();
            }
            var doc = data?.docs[0];

            BookingEntity e = BookingEntity.fromDoc(doc);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width - 32,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 64,
                                        width: 64,
                                        decoration: const BoxDecoration(
                                            color: colorPrimaryLight,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Image.asset(
                                            e.serviceType.imgUrl,
                                            color: colorPrimary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    e.name ?? "",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      //color: e.bookingStatus.getColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: colorPrimaryLight,
                                                    border: Border.all(
                                                      color:
                                                          colorPrimaryLight, // Border color
                                                      width:
                                                          2.0, // Border width
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          50.0), // Stadium border shape
                                                    ),
                                                  ),
                                                  child: Text(
                                                    e.bookingStatus.name,
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                      color: colorPrimary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              e.serviceName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Date Time: ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${DateFormat('hh:mm a').format(e.serviceTime)}, ${DateFormat('d MMM, y').format(e.bookingCreatedTime)}",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Cost: ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${e.price} KS",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  _buildAdditionalFieldsWidget(e),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  StepperWidget(status: e.bookingStatus),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  if (e.bookingStatus ==
                                      BookingStatus.pendingPayment)
                                    SizedBox(
                                      height: 36,
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () async {
                                          context
                                              .read<BookingCubit>()
                                              .updateStatus(
                                                e.bookingId,
                                                BookingStatus
                                                    .bookingAccepted.name,
                                              );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  colorPrimary),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Make Payment",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xFFFFFFFF),

                                            // height: 19/19,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (e.bookingStatus ==
                                      BookingStatus.serviceFinished)
                                    SizedBox(
                                      height: 36,
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () async {
                                          context
                                              .read<BookingCubit>()
                                              .updateStatus(
                                                e.bookingId,
                                                BookingStatus.completed.name,
                                              );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  colorPrimary),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Yes, Service is Done",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xFFFFFFFF),

                                            // height: 19/19,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAdditionalFieldsWidget(BookingEntity e) {
    switch (e.serviceType) {
      case ServiceProviderType.electronic:
        return _buildElectronicWidget(e);
      case ServiceProviderType.laundry:
        return _buildLaundryWidget(e);
      case ServiceProviderType.homeCleaning:
        return _buildHomeCleaningWidget(e);
      case ServiceProviderType.houseMoving:
        return _buildHouseMovingWidget(e);
      case ServiceProviderType.kiloTaxi:
        return _buildKiloTaxiWidget(e);
      case ServiceProviderType.freelancer:
      default:
        return _buildFreelancerWidget(e);
    }
  }

  Widget _buildElectronicWidget(BookingEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Electronic type: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              e.electronicType ?? "",
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              "Electronic Service Name: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              e.electronicServiceName ?? "",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLaundryWidget(BookingEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Total Cloth Count: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              e.totalClothCount.toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              "Total Laundry Price: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${e.totalLaundryPrice.toString()} Ks",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHomeCleaningWidget(BookingEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }

  Widget _buildHouseMovingWidget(BookingEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Car Type: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${e.carName}"),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              "Floor: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${e.floorNo}",
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              "From: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${e.fromAddr}",
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              "To: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${e.toAddr}",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKiloTaxiWidget(BookingEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "From: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${e.fromAddr}",
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text(
              "To: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${e.toAddr}",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFreelancerWidget(BookingEntity e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}
