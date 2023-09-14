import 'package:flutter/material.dart';
import 'package:hakathon_service/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/service_provider_entity.dart';

class ServiceProviderDetailScreen extends StatefulWidget {
  const ServiceProviderDetailScreen({
    super.key,
    required this.service,
    required this.onChanged,
  });

  final ServiceProviderEntity service;
  final Function(ServiceProviderEntity) onChanged;

  @override
  State<ServiceProviderDetailScreen> createState() =>
      _ServiceProviderDetailScreenState();
}

class _ServiceProviderDetailScreenState
    extends State<ServiceProviderDetailScreen> {
  DateTime day = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<DateTime> hourList = [];

  @override
  void initState() {
    super.initState();
    hourList = [
      DateTime(day.year, day.month, day.day, 11),
      DateTime(day.year, day.month, day.day, 12, 10),
      DateTime(day.year, day.month, day.day, 13, 10),
      DateTime(day.year, day.month, day.day, 14, 10),
      // DateTime(day.year, day.month, day.day, 16, 10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          widget.service.serviceName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.service.imgUrl,
              fit: BoxFit.cover,
              height: 320,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.service.serviceName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "5000 Ks/hr",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorPrimaryLight,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "\$15K+",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Total Earned",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorPrimaryLight,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "110",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Job Completed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorPrimaryLight,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "210",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Hours Worked",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                      ),
                      Text(
                        widget.service.address,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(),
                  const Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.service.about,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildServiceAvailableTime(),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onChanged(widget.service);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPrimary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "SELECT",
                          style: regularStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildServiceAvailableTime() {
    List<Widget> widgetList = [];
    for (int index = 0; index < hourList.length; index++) {
      widgetList.add(
        Container(
          width: (MediaQuery.of(context).size.width -
                  (8 * (hourList.length - 1)) -
                  40) /
              hourList.length,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorPrimary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            DateFormat('h:mm a').format(hourList[index]),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Service Available Time",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [...widgetList],
        ),
      ],
    );
  }
}
