import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/utils/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phnoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: Row(
                  children: const [
                    SizedBox(
                      width: 9,
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "Registeration",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorPrimary,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   "Registeration",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: _buildImagePickerWidget(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildTextFieldWidget(
                      label: "Phone Number",
                      controller: _phnoController,
                      inputType: TextInputType.phone,
                    ),
                    _buildTextFieldWidget(
                      label: "Email",
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                    ),
                    _buildTextFieldWidget(
                      label: "Field (Profession)",
                      controller: _fieldController,
                      inputType: TextInputType.text,
                    ),
                    _buildTextFieldWidget(
                      label: "Price Rate/Hr",
                      controller: _rateController,
                      inputType: TextInputType.number,
                    ),
                    _buildTextFieldWidget(
                      label: "Location",
                      controller: _locationController,
                      inputType: TextInputType.text,
                    ),
                    _buildTextFieldWidget(
                      label: "Description",
                      maxlines: 5,
                      controller: _descriptionController,
                      inputType: TextInputType.multiline,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimary),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text("Register"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWidget({
    required String label,
    required TextEditingController controller,
    required TextInputType inputType,
    int? maxlines,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _fieldController,
          keyboardType: inputType,
          maxLines: maxlines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            //  border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(16.0)),

            //   borderSide: BorderSide.none, // Remove border
            // ),
            contentPadding: EdgeInsets.only(
              top: 8,
              right: 16,
              left: 16,
              bottom: 8,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  double imageSize = 90;
  Widget _buildImagePickerWidget() {
    return Stack(
      children: [
        Container(
          width: 98,
          height: 100,
          // color: Colors.blue,
        ),
        Positioned(
          child: ClipOval(
            child: Image.asset("assets/profile.jpg",
                width: imageSize, height: imageSize),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: InkWell(
            onTap: () {
              pickImages();
            },
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  late File file;
  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String path = result.files.single.path ?? "";
      file = File(path);
    } else {
      // User canceled the picker
    }
  }
}
