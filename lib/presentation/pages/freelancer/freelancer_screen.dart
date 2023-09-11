import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hakathon_service/presentation/pages/chat/chat.dart';
import 'package:hakathon_service/presentation/pages/freelancer/freelancer_list_screen.dart';
import 'package:hakathon_service/utils/constants.dart';

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
        backgroundColor: colorPrimary,
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
                    label: "Psychologist",
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/driver.png",
                    label: "Driver",
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/tutor.png",
                    label: "Tutor",
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/babysitter.png",
                    label: "Baby Sitter",
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/business.png",
                    label: "Coach",
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/dogwalker.png",
                    label: "Dog Walker",
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/hairstylist.png",
                    label: "Hair Stylist",
                  ),
                  ServiceCategoryWidget(
                    imgUrl: "assets/gardener.png",
                    label: "Gardener",
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
    required this.label,
  });

  final String imgUrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FreelancerListScreen(
                label: label,
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
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
