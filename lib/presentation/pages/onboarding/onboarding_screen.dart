import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakathon_service/domain/entities/user_entity.dart';
import 'package:hakathon_service/presentation/pages/onboarding/onboarding_success_screen.dart';
import 'package:hakathon_service/utils/constants.dart';

import '../../../bridge/camera/camera_interface.dart';
import '../../../bridge/camera/camera_web_impl.dart';
import '../../../services/user_profile_service.dart';

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
                border: Border.all(
                  // color: Colors.grey.shade400,
                  color: colorPrimary,
                ),
              ),
              child: Center(
                child: Row(
                  children: const [
                    SizedBox(
                      width: 9,
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      // color: Colors.white,
                      color: colorPrimary,
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
            color: colorPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                      validator: phoneValidator,
                    ),
                    _buildTextFieldWidget(
                      label: "Email",
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    _buildTextFieldWidget(
                      label: "Field (Profession)",
                      controller: _fieldController,
                      inputType: TextInputType.text,
                      validator: emptyValidator,
                    ),
                    _buildTextFieldWidget(
                      label: "Price Rate/Hr",
                      controller: _rateController,
                      inputType: TextInputType.number,
                      validator: emptyValidator,
                    ),
                    _buildTextFieldWidget(
                      label: "Location",
                      controller: _locationController,
                      inputType: TextInputType.text,
                      validator: emptyValidator,
                    ),
                    _buildTextFieldWidget(
                      label: "Description",
                      maxlines: 5,
                      controller: _descriptionController,
                      inputType: TextInputType.multiline,
                      validator: emptyValidator,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          await updateProfile();
                        },
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

  String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty';
    }
    return null; // Return null for no error
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty';
    } else if (!isEmailValid(value)) {
      return 'Email format is incorrect!';
    }
    return null; // Return null for no error
  }

  String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty';
    } else if (!isPhoneNumberValid(value)) {
      return 'Ph number format is incorrect!';
    }
    return null; // Return null for no error
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    return emailRegex.hasMatch(email);
  }

  bool isPhoneNumberValid(String phoneNumber) {
    // Regular expression for a 10-digit US phone number
    final phoneRegex = RegExp(r'^\d{11}$');

    return phoneRegex.hasMatch(phoneNumber);
  }

  Widget _buildTextFieldWidget({
    required String label,
    required TextEditingController controller,
    required TextInputType inputType,
    required String? Function(String?) validator,
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          keyboardType: inputType,
          maxLines: maxlines,
          validator: validator,
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

  late Uint8List bytes;
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
              child: imageBytes == null
                  ? Image.asset("assets/profile.jpg",
                      width: imageSize, height: imageSize)
                  : Image.memory(bytes)),
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

  Uint8List? imageBytes;
  Future<void> pickImages() async {
    final ICameraBridge _icameraBridge = Get.put(const CameraBridgeImpl());
    String base64Image = await _icameraBridge.openCamera();
    imageBytes = base64.decode(base64Image);
    setState(() {});
  }

  Future<void> updateProfile() async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection(profileTable)
            .doc(UserProfileService.msisdn)
            .update({
          "email": _emailController.text,
          "phno": _phnoController.text,
          "field": _fieldController.text,
          "priceRate": int.tryParse(_rateController.text) ?? 0,
          "location": _locationController.text,
          "description": _descriptionController.text,
        });
        var userDoc = await FirebaseFirestore.instance
            .collection(profileTable)
            .doc(UserProfileService.msisdn)
            .get();
        UserEntity user = UserEntity.fromDoc(userDoc);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnboardingSuccessScreen(e: user),
            ));
      } catch (e) {}
    } else {}
  }
}
