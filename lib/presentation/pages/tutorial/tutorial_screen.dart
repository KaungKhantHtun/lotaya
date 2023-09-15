import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/user_entity.dart';
import 'package:hakathon_service/presentation/pages/home/home_screen.dart';
import 'package:hakathon_service/services/user_profile_service.dart';
import 'package:hakathon_service/utils/constants.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  CarouselController carouselController = CarouselController();
  List<PageEntity> pageList = [
    PageEntity(
      imgUrl: "assets/aircon_service.jpg",
      title: "Want to complete your tasks?",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    ),
    PageEntity(
      imgUrl: "assets/aircon_service.jpg",
      title: "Just tell us what you need",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    ),
    PageEntity(
      imgUrl: "assets/aircon_service.jpg",
      title: "Just tell us what you need",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    ),
  ];
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    operateUser();
    super.initState();
  }

  operateUser() async {
    UserEntity userEntity = await UserProfileService().getUserProfile();
    bool isNewUser = await UserProfileService().checkMsisdn(userEntity.msisdn);
    if (isNewUser) {
      await UserProfileService().createProfile(userEntity);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeScreen(
                initialIndex: 0,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: colorPrimary,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                        initialIndex: 0,
                      )));
            },
            child: const Text("Skip"),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: pageList.map((e) => _buildPageWidget(e)).toList(),
            carouselController: carouselController,
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: false,
                viewportFraction: 1,
                aspectRatio: 0.88,
                initialPage: 0,
                onPageChanged: (val, _) {
                  carouselController.jumpToPage(val);
                  setState(() {
                    print("new index $val");
                    currentIndex = val;
                  });
                }),
          ),
          Spacer(),
          Center(
            child: DotsIndicator(
              dotsCount: pageList.length,
              position: currentIndex,
            ),
          ),
          // Spacer(),
          const SizedBox(
            height: 32,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            initialIndex: 0,
                          )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: const Text("Next"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildPageWidget(PageEntity e) {
    return Column(
      children: [
        Image.asset(
          e.imgUrl,
          // height: 300,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            e.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            e.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class PageEntity {
  final String title;
  final String description;
  final String imgUrl;

  PageEntity(
      {required this.title, required this.description, required this.imgUrl});
}
