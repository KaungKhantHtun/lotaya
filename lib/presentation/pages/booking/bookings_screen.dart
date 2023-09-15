import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/presentation/cubit/booking_cubit.dart';
import 'package:hakathon_service/presentation/pages/booking/booking_detail_screen.dart';
import 'package:hakathon_service/presentation/pages/booking/bookings_screen_admin.dart';
import 'package:hakathon_service/presentation/pages/chat/chat.dart';
import 'package:hakathon_service/presentation/pages/chat/core/firebase_chat_core.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
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
    ServiceProviderType.homeCleaning,
    ServiceProviderType.houseMoving,
    ServiceProviderType.laundry,
  ];
  List<String> selectedServiceProviderType = [];
  List<String> optionList = [
    "Electronic",
    "Home Cleaning",
    "House Moving",
    "Laundry",
    "Kilo Taxi",
    "Freelancer",
  ];

  @override
  void initState() {
    // TODO: implement initState
    // bookingList = [
    //   booking1,
    //   booking2,
    //   booking2,
    //   booking2,
    //   booking2,
    // ];

    querySnapshot = FirebaseFirestore.instance.collection(bookingTable);
    selectedServiceProviderType = optionList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Enter Password"),
                  content: Container(
                    //height: 40,
                    color: Colors.grey.shade100,
                    //  padding: EdgeInsets.all(8),
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8)),
                      onSubmitted: (value) {
                        Navigator.pop(context);
                        if (value == "Two@Gether!") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingsScreenAdmin(),
                              ));
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: const Text(
            "Bookings",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildFilter(),
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

                    return BookingCardWidget(
                      e: e,
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  SizedBox _buildFilter() {
    return SizedBox(
      width: 200,
      child: DropDownMultiSelect<String>(
        readOnly: true,
        onChanged: (List<String> x) {
          selectedServiceProviderType = x;

          if (selectedServiceProviderType.length == 1) {
            querySnapshot = FirebaseFirestore.instance
                .collection(bookingTable)
                .where('serviceType',
                    isEqualTo: selectedServiceProviderType.first);
          } else if (selectedServiceProviderType.length > 1) {
            querySnapshot = FirebaseFirestore.instance
                .collection(bookingTable)
                .where('serviceType', whereIn: selectedServiceProviderType);
          } else {
            selectedServiceProviderType = optionList;
            querySnapshot = FirebaseFirestore.instance.collection(bookingTable);
          }
          print("Option List: $optionList");
          print("selectedServiceProviderType: $selectedServiceProviderType");
          // setState(() {});
        },
        options: optionList,
        childBuilder: (selectedValues) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              selectedValues.length == optionList.length
                  ? "All"
                  : selectedValues.join(", "),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          );
        },
        // menuItembuilder: (val) {
        //   return Text(val);
        // },

        selectedValues: selectedServiceProviderType,
        // whenEmpty: 'Choose Service Type',
        // decoration: InputDecoration(
        //   contentPadding: EdgeInsets.all(4),
        // ),

        // hint: const Text('Choose Service Type'),
        icon: const Icon(Icons.arrow_drop_down),
        whenEmpty: "All",
      ),
    );
  }
}

class BookingCardWidget extends StatelessWidget {
  const BookingCardWidget({
    super.key,
    required this.e,
  });

  final BookingEntity e;

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: const BoxDecoration(
                          color: colorPrimaryLight, shape: BoxShape.circle),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  e.name ?? "",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    //color: e.bookingStatus.getColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colorPrimaryLight,
                                  border: Border.all(
                                    color: colorPrimaryLight, // Border color
                                    width: 2.0, // Border width
                                  ),
                                  borderRadius: const BorderRadius.all(
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
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("${e.price} KS"),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        _handlePressed(context, e.bookingId, e.name);
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
                if (e.bookingStatus == BookingStatus.pendingPayment)
                  SizedBox(
                    height: 36,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        context.read<BookingCubit>().updateStatus(
                              e.bookingId,
                              BookingStatus.bookingAccepted.name,
                            );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(colorPrimary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
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
                if (e.bookingStatus == BookingStatus.serviceFinished)
                  SizedBox(
                    height: 36,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        context.read<BookingCubit>().updateStatus(
                              e.bookingId,
                              BookingStatus.completed.name,
                            );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(colorPrimary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
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
            Positioned(
                right: 0,
                bottom: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ))
          ],
        ),
      ),
    );
  }

  void _handlePressed(
      BuildContext context, String bookingId, String? name) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(
      adminUser,
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
