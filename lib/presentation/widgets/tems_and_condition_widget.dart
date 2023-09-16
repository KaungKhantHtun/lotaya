import 'package:flutter/material.dart';
import 'package:hakathon_service/utils/constants.dart';

class TermsAndConditonsWidget extends StatefulWidget {
  const TermsAndConditonsWidget({super.key});

  @override
  State<TermsAndConditonsWidget> createState() =>
      _TermsAndConditonsWidgetState();
}

class _TermsAndConditonsWidgetState extends State<TermsAndConditonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: null,
        backgroundColor: colorPrimaryLight,
        foregroundColor: colorPrimary,
        centerTitle: true,
        title: Text("Terms and Conditions"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              ...termsAndConditonList.map((e) => _buildTermAndConditionItem(e)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermAndConditionItem(Map<String, String> map) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          map.keys.first,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(map.values.first),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
