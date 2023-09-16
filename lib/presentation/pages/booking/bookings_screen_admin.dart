import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/presentation/cubit/booking_cubit.dart';
import 'package:hakathon_service/presentation/pages/booking/booking_detail_screen.dart';
import 'package:hakathon_service/presentation/pages/chat/chat.dart';
import 'package:hakathon_service/presentation/pages/chat/core/firebase_chat_core.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';

class BookingsScreenAdmin extends StatefulWidget {
  const BookingsScreenAdmin({Key? key}) : super(key: key);

  @override
  State<BookingsScreenAdmin> createState() => _BookingsScreenAdminState();
}

class _BookingsScreenAdminState extends State<BookingsScreenAdmin> {
  // BookingEntity booking1 = BookingEntity(
  //   bookingId: "12",
  //   name: "Fix You Service",
  //   serviceType: ServiceProviderType.electronic,
  //   serviceProviderId: "1",
  //   serviceName: "Home Appliance Repair",
  //   serviceTime: DateTime.now(),
  //   bookingCreatedTime: DateTime.now(),
  //   bookingStatus: BookingStatus.pending,
  //   address: "No.34, Yadanar Theinkha Street, Kyun Taw Road, Yangon",
  //   long: 12355.45,
  //   lat: 12345.45,
  //   price: 5000,
  //   note: "abc",
  // );
  // BookingEntity booking2 = BookingEntity(
  //   bookingId: "45",
  //   name: "Fix You Service",
  //   serviceType: ServiceProviderType.electronic,
  //   serviceProviderId: "1",
  //   serviceName: "Home Appliance Repair",
  //   serviceTime: DateTime.now(),
  //   bookingCreatedTime: DateTime(2023, 9, 5),
  //   bookingStatus: BookingStatus.pending,
  //   address: "No.34, Yadanar Theinkha Street, Kyun Taw Road, Yangon",
  //   long: 12355.45,
  //   lat: 12345.45,
  //   price: 5000,
  //   note: "abc",
  // );
  List<BookingEntity> bookingList = [];
  late Query<Map<String, dynamic>> querySnapshot;
  List<ServiceProviderType> serviceTypeList = const [
    ServiceProviderType.electronic,
    ServiceProviderType.delivery,
    ServiceProviderType.homeCleaning,
    ServiceProviderType.houseMoving,
    ServiceProviderType.laundry,
  ];
  List<String> selectedServiceProviderType = [];
  List<String> optionList = const [];

  @override
  void initState() {
    // TODO: implement initState
    isAdmin = true;
    // bookingList = [
    //   booking1,
    //   booking2,
    //   booking2,
    //   booking2,
    //   booking2,
    // ];
    querySnapshot = FirebaseFirestore.instance
        .collection(bookingTable)
        .orderBy("bookingCreatedTime", descending: true);
    ;
    optionList = serviceTypeList.map((e) => e.name).toList();
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
        foregroundColor: colorPrimary,
        backgroundColor: colorPrimaryLight,
        centerTitle: true,
        title:  Text(
          "Bookings Request List".toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            // DropDownMultiSelect comes from multiselect
            child: SizedBox(
              width: 200,
              child: DropDownMultiSelect<String>(
                onChanged: (List<String> x) {
                  setState(() {
                    selectedServiceProviderType = x;
                  });
                  if (selectedServiceProviderType.length == 1) {
                    querySnapshot = FirebaseFirestore.instance
                        .collection(bookingTable)
                        .where('serviceType',
                            isEqualTo: selectedServiceProviderType.first);
                  } else if (selectedServiceProviderType.length > 1) {
                    querySnapshot = FirebaseFirestore.instance
                        .collection(bookingTable)
                        .where('serviceType',
                            whereIn: selectedServiceProviderType);
                  } else {
                    querySnapshot =
                        FirebaseFirestore.instance.collection(bookingTable);
                  }
                },
                options: optionList,
                childBuilder: (selectedValues) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      selectedValues.length == optionList.length ||
                              selectedValues.isEmpty
                          ? "All"
                          : selectedValues.join(", "),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  );
                },
                // menuItembuilder: (option) {
                //   // return Text(option.name);
                // },
                selectedValues: selectedServiceProviderType,
                // whenEmpty: 'Choose Service Type',
              ),
            ),
          ),
        ],
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

              return ListView.builder(
                itemCount: data?.size,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  var doc = data?.docs[index];
                  BookingEntity e = BookingEntity.fromDoc(doc);

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookingDetailScreen(
                                bookingId: e.bookingId,
                              )));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
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
                                                    width: 2.0, // Border width
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
                                                    fontWeight: FontWeight.bold,
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
                                height: 8,
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
                                  Text("${e.price} KS"),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      _handlePressed(
                                          context, e.bookingId, e.name);
                                    },
                                    child: Image.asset(
                                      "assets/bubble-chat.png",
                                      width: 24,
                                      color: colorPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (e.bookingStatus ==
                                  BookingStatus.serviceRequested)
                                Row(
                                  children: [
                                    TextButton.icon(
                                      label: Text(
                                        "Reject",
                                        style: TextStyle(color: errorColor),
                                      ),
                                      onPressed: () => context
                                          .read<BookingCubit>()
                                          .updateStatus(
                                              e.bookingId, "Rejected"),
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: errorColor,
                                      ),
                                    ),
                                    TextButton.icon(
                                      label: Text(
                                        "Accept",
                                        style: TextStyle(color: successColor),
                                      ),
                                      onPressed: () => context
                                          .read<BookingCubit>()
                                          .updateStatus(
                                              e.bookingId,
                                              BookingStatus
                                                  .pendingPayment.name),
                                      icon: Icon(
                                        Icons.check_circle_outline,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              if (e.bookingStatus ==
                                  BookingStatus.bookingAccepted)
                                SizedBox(
                                  height: 36,
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () async {
                                      context.read<BookingCubit>().updateStatus(
                                            e.bookingId,
                                            BookingStatus
                                                .serviceProcessing.name,
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
                                      "Start Service",
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
                                  BookingStatus.serviceProcessing)
                                SizedBox(
                                  height: 36,
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () async {
                                      context.read<BookingCubit>().updateStatus(
                                            e.bookingId,
                                            BookingStatus.serviceFinished.name,
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
                                      "Done",
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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _handlePressed(
      BuildContext context, String bookingId, String? name) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(
      currentUser,
      roomId: bookingId,
      roomName: name,
    );

    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }
}
