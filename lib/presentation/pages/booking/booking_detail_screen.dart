import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/presentation/pages/chat/chat.dart';
import 'package:hakathon_service/presentation/pages/chat/core/firebase_chat_core.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../chat_screen.dart';

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
                                      e.name,
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
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "aircon service & Repair & Install and Maintenance.aircon service & Repair & Install and Maintenance.",
                                  style: TextStyle(
                                    fontSize: 13,
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
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text("Time: "),
                          Text(
                            DateFormat('hh:mm a').format(e.serviceTime),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Text("Date: "),
                          Text(
                            DateFormat('d MMM, y').format(e.bookingCreatedTime),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Text("Amount: "),
                          Text(
                            "${e.price ?? 0} KS",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          Text("Vendor: "),
                          Text(
                            "Yet to be assigned",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              _handlePressed(context, widget.bookingId);
                            },
                            // child: Text(
                            //   "View Details",
                            //   style: TextStyle(
                            //     color: colorPrimary,
                            //   ),
                            // ),
                            child: Image.asset(
                              "assets/bubble-chat.png",
                              width: 30,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => const ChatScreen()));
                  //     },
                  //     // child: Text(
                  //     //   "View Details",
                  //     //   style: TextStyle(
                  //     //     color: colorPrimary,
                  //     //   ),
                  //     // ),
                  //     child: Image.asset(
                  //       "assets/bubble-chat.png",
                  //       width: 30,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _handlePressed(BuildContext context, String bookingId) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance
        .createRoom(isAdmin ? currentUser : adminUser, roomId: bookingId);

    navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }
}
