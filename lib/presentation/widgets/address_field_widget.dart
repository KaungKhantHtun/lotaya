import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakathon_service/services/location_service.dart';

class AddressFieldWidget extends StatefulWidget {
  AddressFieldWidget(
      {Key? key, required this.addressController, required this.onChanged})
      : super(key: key);
  final TextEditingController addressController;
  final Function(String address, LatLng latlng) onChanged;

  @override
  State<AddressFieldWidget> createState() => _AddressFieldWidgetState();
}

class _AddressFieldWidgetState extends State<AddressFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.addressController,
      readOnly: true,
      maxLines: 1,
      keyboardType: TextInputType.multiline,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LocationPage();
            },
          ),
        ).then((value) {
          widget.onChanged(value[0], value[1]);
        });
      },
      decoration: InputDecoration(
        hintText: 'Your Address',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.gps_fixed),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LocationPage();
                },
              ),
            ).then((value) {
              print("@>value: $value");
              widget.onChanged(value[0], value[1]);
            });
          },
        ),
      ),
    );
  }
}
