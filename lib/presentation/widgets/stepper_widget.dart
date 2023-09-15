import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/booking_status.dart';
import 'package:hakathon_service/utils/constants.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key, required this.status});
  final BookingStatus status;

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int activeIndex = 3;
  List<StepperData> stepperData = [];
  @override
  void initState() {
    activeIndex = getActiveIndex(widget.status);
    stepperData = [
      getStepperData(
        status: BookingStatus.serviceRequested,
        step: 1,
        subtitle: "Your service is requested",
        activeIndex: activeIndex,
      ),
      getStepperData(
        status: BookingStatus.pendingPayment,
        step: 2,
        subtitle: "Your booking is pending in payment",
        activeIndex: activeIndex,
      ),
      getStepperData(
        status: BookingStatus.bookingAccepted,
        step: 3,
        subtitle: "Your booking is accepted",
        activeIndex: activeIndex,
      ),
      getStepperData(
        status: BookingStatus.serviceProcessing,
        step: 4,
        subtitle: "Your service is processing",
        activeIndex: activeIndex,
      ),
      getStepperData(
        status: BookingStatus.serviceFinished,
        step: 5,
        subtitle: "Your service is finished",
        activeIndex: activeIndex,
      ),
      getStepperData(
        status: BookingStatus.completed,
        step: 6,
        subtitle: "Your service is completed",
        activeIndex: activeIndex,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnotherStepper(
      stepperList: stepperData,
      stepperDirection: Axis.vertical,
      activeBarColor: colorPrimary,
      inActiveBarColor: Colors.grey.shade500,
      barThickness: 1,
      activeIndex: activeIndex,
      inverted: false,
      verticalGap: 30,
      iconWidth: 30, // Height that will be applied to all the stepper icons
      iconHeight: 30, // Width that will be applied to all the stepper icons
    );
  }

  int getActiveIndex(BookingStatus status) {
    switch (status) {
      case BookingStatus.pendingPayment:
        return 2;
      case BookingStatus.bookingAccepted:
        return 3;
      case BookingStatus.serviceProcessing:
        return 4;
      case BookingStatus.serviceFinished:
        return 5;
      case BookingStatus.completed:
        return 6;
      case BookingStatus.serviceRequested:
      default:
        return 1;
    }
  }

  StepperData getStepperData({
    required BookingStatus status,
    required int step,
    required String subtitle,
    required int activeIndex,
  }) {
    Color circleColor = colorPrimary;
    Color subtitleColor = Colors.grey.shade500;
    Color titleColor = Colors.black;

    if (step <= activeIndex) {
      circleColor = Colors.green.shade400;
    } else if (step > activeIndex) {
      circleColor = Colors.grey.shade500;
    }

    return StepperData(
      title: StepperText(
        status.name,
        textStyle: TextStyle(
          color: titleColor, fontWeight: FontWeight.w600,
          // color: status.getColor,
        ),
      ),
      subtitle: StepperText(
        subtitle,
        textStyle: TextStyle(
          color: subtitleColor,
        ),
      ),
      iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              // color: status.getColor,
              // color: colorPrimary,
              color: circleColor,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Center(
            child: Text(
              step.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
