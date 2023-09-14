import 'package:flutter/material.dart';

class TotalCostWidget extends StatefulWidget {
  const TotalCostWidget({super.key, required this.price});

  final double price;
  @override
  State<TotalCostWidget> createState() => _TotalCostWidgetState();
}

class _TotalCostWidgetState extends State<TotalCostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total Cost",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${widget.price} Ks",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
