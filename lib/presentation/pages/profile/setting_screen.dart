import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:hakathon_service/presentation/pages/profile/profile_screen.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../services/user_profile_service.dart';
import '../../../utils/constants.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/tems_and_condition_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Query<Map<String, dynamic>> querySnapshot =
      FirebaseFirestore.instance.collection(profileTable);
  bool showLoading = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        showLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorPrimary,
        backgroundColor: colorPrimaryLight,
        title:  Text(
          "Profile".toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(profileTable)
                    .doc(UserProfileService.msisdn)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      showLoading) {
                    print("loading data");

                    return const LoadingWidget();
                  } else if (!snapshot.hasData) {
                    return Container();
                  } else {
                    final data = snapshot.data;

                    UserEntity profile = UserEntity.fromDoc(data);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              ClipOval(
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  color: colorPrimary,
                                  size: 90,
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                profile.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  }
                },
              ),
              _buildInfoWidget(
                title: "Personal Information",
                imgUrl: "assets/setting/user.png",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ));
                },
              ),
              _buildInfoWidget(
                title: "Register for Profession",
                imgUrl: "assets/setting/signup.png",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
                      ));
                },
              ),
              _buildInfoWidget(
                title: "Contact Us",
                imgUrl: "assets/setting/call.png",
                onPressed: () {},
              ),
              _buildInfoWidget(
                title: "Privacy Policy",
                imgUrl: "assets/setting/privacy_policy.png",
                onPressed: () {},
              ),
              _buildInfoWidget(
                title: "Terms & Conditions",
                imgUrl: "assets/setting/term_condition.png",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const TermsAndConditonsWidget();
                      });
                },
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoWidget(
    {required String title,
    required String imgUrl,
    required Function onPressed}) {
  return InkWell(
    onTap: () {
      onPressed.call();
    },
    child: Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                child: Image.asset(imgUrl),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    // color: Color(0xffafb0c6),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
        ],
      ),
    ),
  );
}
