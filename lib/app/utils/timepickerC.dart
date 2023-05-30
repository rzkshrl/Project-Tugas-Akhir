// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimePickerController extends GetxController {
  var selectedTime = const TimeOfDay(hour: -1, minute: -1).obs;

  Future<void> timePicker(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      update();
      int hour24 = selectedTime.value.hourOfPeriod;
      int minute = selectedTime.value.minute;
      var isAM = selectedTime.value.period == DayPeriod.am;

      if (!isAM && hour24 < 12) {
        hour24 += 12;
      } else if (isAM && hour24 == 12) {
        hour24 = 0;
      }

      String hourString = hour24.toString().padLeft(2, '0');
      String minuteString = minute.toString().padLeft(2, '0');
      controller.text = '$hourString:$minuteString';
      if (kDebugMode) {
        '$hourString:$minuteString';
      }
    }
  }

  Future<void> timePickerEdit(
      BuildContext context, TextEditingController controller) async {
    List<String> parts = controller.text.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    TimeOfDay initialTime = TimeOfDay(hour: hour, minute: minute);
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      update();
      int hour24 = selectedTime.value.hourOfPeriod;
      int minute = selectedTime.value.minute;
      var isAM = selectedTime.value.period == DayPeriod.am;

      if (!isAM && hour24 < 12) {
        hour24 += 12;
      } else if (isAM && hour24 == 12) {
        hour24 = 0;
      }

      String hourString = hour24.toString().padLeft(2, '0');
      String minuteString = minute.toString().padLeft(2, '0');
      controller.text = '$hourString:$minuteString';
      if (kDebugMode) {
        '$hourString:$minuteString';
      }
    }
  }
}
