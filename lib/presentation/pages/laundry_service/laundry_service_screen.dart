import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/cloth_entity.dart';
import 'package:hakathon_service/domain/entities/cloth_with_count_entity.dart';
import 'package:hakathon_service/domain/entities/laundry_booking_confirm_entity.dart';
import 'package:hakathon_service/domain/entities/wear_type.dart';
import 'package:hakathon_service/utils/constants.dart';

import '../../../domain/entities/laundry_service_type.dart';
import 'laundry_order_confirm_screen.dart';

class LaundryServiceScreen extends StatefulWidget {
  LaundryServiceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LaundryServiceScreen> createState() => _LaundryServiceScreenState();
}

class _LaundryServiceScreenState extends State<LaundryServiceScreen> {
  Map<WearType, List<ClothEntity>> clothMap = {
    WearType.outWear: originalClothList,
    WearType.casualWear: originalClothList,
    WearType.formalWear: originalClothList,
  };
  List<LaundryServiceType> serviceList = [
    LaundryServiceType.dryCleaning,
    LaundryServiceType.washAndIron,
    LaundryServiceType.iron,
  ];

  LaundryServiceType selectedServiceType = LaundryServiceType.dryCleaning;
  Map<LaundryServiceType, Map<String, int>> countMap = {
    LaundryServiceType.dryCleaning: {},
    LaundryServiceType.washAndIron: {},
    LaundryServiceType.iron: {}
  };

  @override
  void initState() {
    clothMap.values.forEach((list) {
      list.forEach((element) {
        countMap[LaundryServiceType.dryCleaning]![element.id] = 0;
        countMap[LaundryServiceType.washAndIron]![element.id] = 0;
        countMap[LaundryServiceType.iron]![element.id] = 0;
      });
    });

    // countMap.forEach((key1, value1) {
    //   value1.forEach((key2, value2) {
    //     countMap[key1]![key2] = 0;
    //   });
    // });
    print(countMap);
    super.initState();
  }

  int totalCount = 0;
  double totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 9,
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "LAUNDRY",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              //  border: Border)
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...serviceList
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedServiceType = e;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: selectedServiceType == e
                                        ? colorPrimary
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: Text(
                                      e.name,
                                      style: TextStyle(
                                        color: selectedServiceType == e
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      ...clothMap.entries.map((list) {
                        ExpandableController _controller = ExpandableController(
                            initialExpanded:
                                list.key == WearType.outWear ? true : false);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ExpandablePanel(
                            theme: ExpandableThemeData(),
                            controller: _controller,
                            header: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    list.key.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: list.value.map(
                                  (e) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: colorPrimary
                                                    .withOpacity(0.3),
                                                child: Image.asset(
                                                  e.imgUrl,
                                                  width: 30,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    e.name,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "${e.getPrice(selectedServiceType).toString()} Ks",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (countMap[selectedServiceType]![
                                                              e.id] ==
                                                          null ||
                                                      countMap[selectedServiceType]![
                                                              e.id]! <=
                                                          1) {
                                                    countMap[
                                                            selectedServiceType]![
                                                        e.id] = 0;
                                                  } else {
                                                    countMap[
                                                            selectedServiceType]![
                                                        e.id] = countMap[
                                                                selectedServiceType]![
                                                            e.id]! -
                                                        1;
                                                  }
                                                  totalCount = getTotalCount();
                                                  totalAmount =
                                                      getTotalAmount();
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                countMap[selectedServiceType]![
                                                        e.id]
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (countMap[
                                                              selectedServiceType]![
                                                          e.id] ==
                                                      null) {
                                                    countMap[
                                                            selectedServiceType]![
                                                        e.id] = 1;
                                                  } else {
                                                    countMap[
                                                            selectedServiceType]![
                                                        e.id] = countMap[
                                                                selectedServiceType]![
                                                            e.id]! +
                                                        1;
                                                  }
                                                  totalCount = getTotalCount();
                                                  totalAmount =
                                                      getTotalAmount();
                                                  setState(() {});

                                                  print(countMap);
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total clothes : $totalCount items",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Total Price : $totalAmount Ks",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  _buildContinueButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        if (totalCount > 0) {
          List<ClothWithCountEntity> clothList = [];
          countMap.keys.forEach((type) {
            countMap[type]!.forEach((id, count) {
              clothList.add(
                ClothWithCountEntity(
                    name: originalClothList
                        .where((element) => element.id == id)
                        .first
                        .name,
                    imgUrl: originalClothList
                        .where((element) => element.id == id)
                        .first
                        .imgUrl,
                    serviceType: type,
                    price: originalClothList
                        .where((element) => element.id == id)
                        .first
                        .getPrice(type),
                    clothId: id,
                    count: count),
              );
            });
          });
          // clothMap.values.forEach((element) {
          //   element.map((e) {
          //     return ClothWithCountEntity(
          //         serviceType: serviceType,
          //         price: price,
          //         clothId: clothId,
          //         count: count);
          //   });
          //   // clothList.addAll();
          // });
          LaundryBookingConfirmEntity bookingConfirm =
              LaundryBookingConfirmEntity(
            clothList: clothList,
            serviceName: "Clean Cool Laundry Service",
            totalCount: totalCount,
            totalPrice: totalAmount,
          );

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LaundryOrderConfirmScreen(
                  laundryBookingConfirmEntity: bookingConfirm)));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            totalCount == 0 ? Colors.grey.shade500 : colorSecondary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Confirm",
          style: regularStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  int getTotalCount() {
    int total = 0;
    countMap.forEach((key1, value1) {
      value1.forEach((key, value2) {
        total += value2;
      });
    });
    return total;
    // lothMap.values.forEach((list) {
    //   list.forEach((element) {
    //     countMap[element.id] = 0;
    //   });
    // });
  }

  double getTotalAmount() {
    double total = 0;

    countMap.forEach((key1, value1) {
      value1.forEach((key, value2) {
        total += getPrice(key) * value2;
      });
    });
    return total;
  }

  double getPrice(String clothId) {
    List<ClothEntity> clothList = [];
    clothMap.values.forEach((element) {
      clothList.addAll(element);
    });
    double price = 0;
    List<ClothEntity> list =
        clothList.where((element) => element.id == clothId).toList();
    if (list.isNotEmpty) {
      price = list.first.getPrice(selectedServiceType);
    }

    return price;
  }
}
