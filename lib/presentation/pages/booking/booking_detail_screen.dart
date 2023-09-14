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

import '../../cubit/booking_cubit.dart';

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
      body: BlocProvider(
        create: (_) => BookingCubit(),
        child: StreamBuilder(
          stream: querySnapshot.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "assets/aircon_service.jpg",
                                fit: BoxFit.fitHeight,
                                width: 70,
                                height: 70,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.bookingStatus.name,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: e.bookingStatus.getColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        e.name ?? "",
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff84888d),
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
                                      fontSize: 16,
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

  void _handlePressed(BuildContext context, String bookingId) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance
        .createRoom(isAdmin ? currentUser : adminUser, roomId: bookingId);
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

    navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
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
