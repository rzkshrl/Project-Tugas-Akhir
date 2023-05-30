// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../theme/theme.dart';

Widget datePickerDialog(
    DateRangePickerSelectionMode selectionMode,
    dynamic Function(Object?)? onSubmit,
    void Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged,
    DateRangePickerController? controller) {
  return Dialog(
    child: Container(
      padding: EdgeInsets.all(1.h),
      height: 50.h,
      width: 25.w,
      // color: light,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SfDateRangePicker(
          todayHighlightColor: Blue1,
          selectionColor: Blue1,
          rangeSelectionColor: Blue1.withOpacity(0.2),
          startRangeSelectionColor: Blue1.withOpacity(0.5),
          endRangeSelectionColor: Blue1.withOpacity(0.5),
          monthViewSettings: const DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
          ),
          selectionMode: selectionMode,
          showActionButtons: true,
          cancelText: "Batal",
          confirmText: "OK",
          onCancel: () => Get.back(),
          onSelectionChanged: onSelectionChanged,
          controller: controller,
          onSubmit: onSubmit),
    ),
  );
}
