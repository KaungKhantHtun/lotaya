import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/service_provider_entity.dart';

import '../../domain/entities/service_provider_type.dart';
import '../../utils/constants.dart';
import '../pages/service_provider/service_provider_list_screen.dart';

class ServiceProviderSelect extends StatefulWidget {
  const ServiceProviderSelect(
      {super.key,
      required this.type,
      required this.serviceProviderController,
      required this.onChanged});
  final ServiceProviderType type;
  final TextEditingController serviceProviderController;
  final Function(String) onChanged;
  @override
  State<ServiceProviderSelect> createState() => _ServiceProviderSelectState();
}

class _ServiceProviderSelectState extends State<ServiceProviderSelect> {
  List<ServiceProviderEntity> list = [];

  @override
  void initState() {
    list = serviceProviderMap[widget.type]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.serviceProviderController,
      readOnly: true,
      maxLines: 1,
      keyboardType: TextInputType.multiline,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ServiceProviderListScreen(
                label: widget.type.name,
                list: list,
                onChanged: (val) {
                  widget.onChanged(val.serviceName);
                },
              );
            },
          ),
        ).then((value) {
          // widget.onChanged(value[0]);
        });
      },
      decoration: InputDecoration(
        // label: const Text("Service Provider(optional)"),
        hintText: 'Select Service Provider (optional)',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ServiceProviderListScreen(
                    label: widget.type.name,
                    list: list,
                    onChanged: (val) {
                      widget.onChanged(val.serviceName);
                    },
                  );
                },
              ),
            ).then((value) {
              print("@>value: $value");
              // widget.onChanged(value[0]);
            });
          },
        ),
      ),
    );
  }
}
