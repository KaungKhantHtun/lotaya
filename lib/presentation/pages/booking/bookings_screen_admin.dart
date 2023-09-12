import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_entity.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/domain/entities/service_provider_type.dart';
import 'package:hakathon_service/presentation/pages/booking/booking_detail_screen.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';

class BookingsScreenAdmin extends StatefulWidget {
  const BookingsScreenAdmin({Key? key}) : super(key: key);

  @override
  State<BookingsScreenAdmin> createState() => _BookingsScreenAdminState();
}

class _BookingsScreenAdminState extends State<BookingsScreenAdmin> {
  BookingEntity booking1 = BookingEntity(
    bookingId: "12",
    name: "Fix You Service",
    serviceType: ServiceProviderType.electronic,
    serviceProviderId: "1",
    serviceName: "Home Appliance Repair",
    serviceTime: DateTime.now(),
    bookingCreatedTime: DateTime.now(),
    bookingStatus: BookingStatus.pending,
    address: "No.34, Yadanar Theinkha Street, Kyun Taw Road, Yangon",
    long: 12355.45,
    lat: 12345.45,
    price: 5000,
    note: "abc",
  );
  BookingEntity booking2 = BookingEntity(
    bookingId: "45",
    name: "Fix You Service",
    serviceType: ServiceProviderType.electronic,
    serviceProviderId: "1",
    serviceName: "Home Appliance Repair",
    serviceTime: DateTime.now(),
    bookingCreatedTime: DateTime(2023, 9, 5),
    bookingStatus: BookingStatus.pending,
    address: "No.34, Yadanar Theinkha Street, Kyun Taw Road, Yangon",
    long: 12355.45,
    lat: 12345.45,
    price: 5000,
    note: "abc",
  );
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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    isAdmin = true;
    bookingList = [
      booking1,
      booking2,
      booking2,
      booking2,
      booking2,
    ];
    querySnapshot = FirebaseFirestore.instance.collection(bookingTable);
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
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Bookings Request List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
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
                whenEmpty: 'Choose Service Type',
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: querySnapshot.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  print(e.bookingStatus);

                  return Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        "aircon service & Repair & Install and Maintenance.aircon service & Repair & Install and Maintenance.",
                                        style: const TextStyle(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                  DateFormat('d MMM, y')
                                      .format(e.bookingCreatedTime),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                            SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                TextButton.icon(
                                  label: Text(
                                    "Reject",
                                    style: TextStyle(color: errorColor),
                                  ),
                                  onPressed: () =>
                                      updateStatus(doc!.id, "Rejected"),
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
                                  onPressed: () =>
                                      updateStatus(doc!.id, "Pending Payment"),
                                  icon: Icon(
                                    Icons.check_circle_outline,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingDetailScreen(
                                        bookingId: e.bookingId,
                                      )));
                            },
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                color: colorPrimary,
                              ),
                            ),
                            // child: Image.asset(
                            //   "assets/bubble-chat.png",
                            //   width: 30,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  updateStatus(String id, String status) {
    print(id);
    final DocumentReference docRef = firestore.collection(bookingTable).doc(id);
    docRef.update(
      {
        "bookingStatus": status,
      },
    );
  }
}
