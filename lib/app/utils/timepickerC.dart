import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';

class TimePickerController extends GetxController {
  var selectedTime = TimeOfDay.now().obs;

  void timePicker(
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
    }
  }
}
