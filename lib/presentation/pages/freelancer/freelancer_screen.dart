import 'package:flutter/material.dart';
import 'package:hakathon_service/presentation/pages/freelancer/freelancer_list_screen.dart';
import 'package:hakathon_service/utils/constants.dart';

import '../../../domain/entities/freelancer_entity.dart';

class FreelancerScreen extends StatefulWidget {
  const FreelancerScreen({super.key});

  @override
  State<FreelancerScreen> createState() => _FreelancerScreenState();
}

class _FreelancerScreenState extends State<FreelancerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorPrimary,
        backgroundColor: colorPrimaryLight,
        centerTitle: true,
        title: const Text(
          "FREELANCERS",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What service are you \nlooking for?",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 48,
              ),
              Wrap(
                children: [
                  ServiceCategoryWidget(
                    imgUrl: "assets/psychologist.png",
                    type: FreelancerType.psychologist,
                    list: psychologistList,
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/driver.png",
                    type: FreelancerType.driver,
                    list: driverList,
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/tutor.png",
                    type: FreelancerType.tutor,
                    list: tutorList,
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/babysitter.png",
                    type: FreelancerType.babySitter,
                    list: babySitterList,
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/business.png",
                    type: FreelancerType.coach,
                    list: coachList,
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/nursing.png",
                    type: FreelancerType.nurse,
                    list: nurseList,
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/hairstylist.png",
                    type: FreelancerType.hairStylist,
                    list: hairStylistList,
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/gardener.png",
                    type: FreelancerType.gardener,
                    list: gardenerList,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCategoryWidget extends StatelessWidget {
  const ServiceCategoryWidget({
    super.key,
    required this.imgUrl,
    required this.type,
    required this.list,
  });

  final String imgUrl;
  final FreelancerType type;
  final List<FreelancerEntity> list;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FreelancerListScreen(
                type: type,
                list: list,
              ),
            ));
      },
      child: SizedBox(
        width: (MediaQuery.of(context).size.width / 3) - 12,
        height: 128,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration:
                  BoxDecoration(color: colorPrimary, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  imgUrl,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              type.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
