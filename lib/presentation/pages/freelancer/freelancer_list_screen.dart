import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hakathon_service/presentation/pages/freelancer/freelancer_detail_screen.dart';
import 'package:hakathon_service/utils/constants.dart';

import '../../../domain/entities/freelancer_entity.dart';

class FreelancerListScreen extends StatefulWidget {
  const FreelancerListScreen(
      {super.key, required this.type, required this.list});

  final FreelancerType type;
  final List<FreelancerEntity> list;

  @override
  State<FreelancerListScreen> createState() => _FreelancerListScreenState();
}

class _FreelancerListScreenState extends State<FreelancerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          "${widget.type.name.toUpperCase()}S",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: colorPrimaryLight,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.type.name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              ...widget.list
                  .map((e) => FreelancerCardWidget(
                        freelancer: e,
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class FreelancerCardWidget extends StatelessWidget {
  FreelancerCardWidget({
    super.key,
    required this.freelancer,
  });

  final FreelancerEntity freelancer;

  String fakeImage = "https://i.pravatar.cc/300?u=${faker.person.name()}";
  String fakeName = faker.person.name();
  String fakeLocation = faker.address.city();
  int fakeRate = faker.randomGenerator.integer(100000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 168,
            child: Container(
              height: 156,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " " + fakeName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on),
                                    Text(
                                      freelancer.location,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FreelacerDetailScreen(
                                        freelancer: freelancer,
                                        name: fakeName,
                                        imgUrl: fakeImage,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "View Details",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: colorPrimary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        "Specialized: ${freelancer.type.name}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "Hourly Rate: ${freelancer.hourlyRate} Ks",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RatingBar.builder(
                    initialRating: faker.randomGenerator.integer(5).toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 16,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                fakeImage,
                height: 80,
                width: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
