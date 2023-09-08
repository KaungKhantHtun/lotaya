import 'package:flutter/material.dart';
import 'package:hakathon_service/presentation/pages/electronic_service/electronic_service_screen.dart';

import '../../domain/entities/service_provider_entity.dart';
import '../../domain/entities/service_provider_type.dart';
import '../../utils/constants.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  Category c1 = Category(
      serviceName: "Clean Cool Service",
      category: "Clean",
      price: 5000,
      worker: "Daw Phyu",
      rating: 4,
      workerImage: "assets/clean_worker_1.jpg");
  Category c2 = Category(
      serviceName: "Clean Cool Service",
      category: "Clean",
      price: 5000,
      worker: "Daw Phyu",
      rating: 4,
      workerImage: "assets/clean_worker_1.jpg");
  Category c3 = Category(
      serviceName: "Clean Cool Service",
      category: "Clean",
      price: 5000,
      worker: "Daw Phyu",
      rating: 4,
      workerImage: "assets/clean_worker_1.jpg");
  Category c4 = Category(
      serviceName: "Clean Cool Service",
      category: "Clean",
      price: 5000,
      worker: "Daw Phyu",
      rating: 4,
      workerImage: "assets/clean_worker_1.jpg");
  Category c5 = Category(
      serviceName: "Clean Cool Service",
      category: "Clean",
      price: 5000,
      worker: "Daw Phyu",
      rating: 4,
      workerImage: "assets/clean_worker_1.jpg");
  Category c6 = Category(
      serviceName: "Clean Cool Service",
      category: "Clean",
      price: 5000,
      worker: "Daw Phyu",
      rating: 4,
      workerImage: "assets/clean_worker_1.jpg");

  List<Category> categoryList = [];

  @override
  void initState() {
    categoryList = [c1, c2, c3, c4, c5, c6];
    super.initState();
  }

  ServiceProviderEntity serviceProviderEntity = ServiceProviderEntity(
      serviceId: "1",
      serviceName: "Home Appliance Repair",
      about: "We offer professional reparing service on-demand",
      priceRate: 5000,
      serviceType: ServiceProviderType.electronic,
      rating: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: colorPrimary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        // Use the GridView.builder constructor for efficiency with large lists
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
        ),
        itemCount: categoryList.length, // Number of items in the grid
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ElectronicServiceScreen(
                        serviceProvider: serviceProviderEntity,
                      )));
            },
            child: Card(
              elevation: 5.0, // Card elevation (shadow)
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    categoryList[index].workerImage,
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        categoryList[index].rating,
                        (index) => const Icon(Icons.star),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(categoryList[index].serviceName),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final String serviceName;
  final String category;
  final double price;
  final String worker;
  final int rating;
  final String workerImage;

  Category(
      {required this.serviceName,
      required this.category,
      required this.price,
      required this.worker,
      required this.rating,
      required this.workerImage});
}
