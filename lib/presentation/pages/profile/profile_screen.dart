import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../services/user_profile_service.dart';
import '../../../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // UserEntity profile = UserEntity(
  //   userId: "4566",
  //   kycStatus: "LEVEL 2",
  //   msisdn: "09401531039",
  //   name: "Ei Zin Htun",
  //   dob: "24.4.1996",
  //   gender: "Female",
  //   nrc: "8/HTALANA(N)123456",
  // );
  Query<Map<String, dynamic>> querySnapshot =
      FirebaseFirestore.instance.collection(profileTable);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: colorPrimary,
        //   ),
        // ),
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        // stream: querySnapshot.snapshots(),
        stream: FirebaseFirestore.instance
            .collection(profileTable)
            .doc(UserProfileService.msisdn)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            final data = snapshot.data;
            // if (data?.docs.length == 0) {
            //   return Container();
            // }
            // var doc = data?.docs[0];
            UserEntity profile = UserEntity.fromDoc(data);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    // color: colorPrimary.withOpacity(0.1),
                    color: Colors.white,
                    child: Center(
                      child: ClipOval(
                        child: Image.asset("assets/profile.jpg",
                            width: 90, height: 90),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "User Information",
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildInfoWidget(
                            title: "First Name", value: profile.name),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildInfoWidget(title: "Phone", value: profile.msisdn),
                        const SizedBox(
                          height: 16,
                        ),
                        if (profile.dob != null)
                          Column(
                            children: [
                              _buildInfoWidget(
                                  title: "Date of Birth",
                                  value: profile.dob ?? ""),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        if (profile.gender != null)
                          Column(
                            children: [
                              _buildInfoWidget(
                                  title: "Gender", value: profile.gender ?? ""),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        _buildInfoWidget(
                            title: "NRC", value: profile.nrc ?? ""),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Widget _buildInfoWidget({required String title, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Color(0xffafb0c6),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xff242646),
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Divider(
        color: Colors.grey.shade400,
      ),
    ],
  );
}
