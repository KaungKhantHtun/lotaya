import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        child: Text(
          msg,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
