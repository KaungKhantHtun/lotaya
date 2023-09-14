import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/presentation/cubit/booking_cubit.dart';
import 'package:hakathon_service/presentation/pages/chat/chat.dart';
import 'package:hakathon_service/presentation/pages/chat/core/firebase_chat_core.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

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
            return Container(
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.name ?? "",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  //color: e.bookingStatus.getColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Flexible(
                                                child: Container(
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
                                if (e.serviceType ==
                                    ServiceProviderType.houseMoving) ...[
                                  Row(
                                    children: [
                                      const Text(
                                        "Car Type: ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${e.toAddr}",
                                      ),
                                    ],
                                  ),
                                ],
                                if (e.serviceType ==
                                    ServiceProviderType.kiloTaxi) ...[
                                  Row(
                                    children: [
                                      const Text(
                                        "From: ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${e.toAddr}",
                                      ),
                                    ],
                                  ),
                                ],
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
            );
          }
        },
      ),
    );
  }
}
