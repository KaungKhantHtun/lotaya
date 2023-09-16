import 'package:flutter/material.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../utils/constants.dart';
import '../profile/profile_screen.dart';

class OnboardingSuccessScreen extends StatefulWidget {
  OnboardingSuccessScreen({Key? key, required this.e}) : super(key: key);
  final UserEntity e;

  @override
  State<OnboardingSuccessScreen> createState() =>
      _OnboardingSuccessScreenState();
}

class _OnboardingSuccessScreenState extends State<OnboardingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: colorPrimary,
          ),
        ),
        foregroundColor: colorPrimary,
        backgroundColor: colorPrimaryLight,
        title: Text(
          "Success".toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Onboarding Success",
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Hi  ${widget.e.name}, You're successfully registered as a ${widget.e.field}. Now you can accept your orders and provide services from Our App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text("Done"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
