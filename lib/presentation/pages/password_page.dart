import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hakathon_service/presentation/pages/home/home_screen.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(48),
            color: Colors.grey.shade100,
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: "password"),
              onSubmitted: (value) {
                Navigator.pop(context);
                if (value == "HaHaHa") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(
                          initialIndex: 0,
                        ),
                      ));
                }
              },
            ),
          ),
        ));
  }
}
