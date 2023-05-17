import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';

class TimePickerController extends GetxController {
  var selectedTime = TimeOfDay.now().obs;

  void timePickerMasuk(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      final String formatTime = selectedTime.value.format(Get.context!);
      textC.masukJamKerjaC.text = formatTime;
    }
  }

  void timePickerKeluar(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      final String formatTime = selectedTime.value.format(Get.context!);
      textC.keluarJamKerjaC.text = formatTime;
    }
  }
}
