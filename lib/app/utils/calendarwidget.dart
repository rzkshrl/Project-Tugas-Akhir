import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/controller/calendars_controller.dart';
import 'package:project_tugas_akhir/app/modules/detail_presensi/controllers/detail_presensi_controller.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controller/api_controller.dart';
import '../data/models/firestorescanlogmodel.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiC = Get.put(APIController(context1: context));
    return GetBuilder<CalendarsController>(builder: (c) {
      return SafeArea(
        child: FutureBuilder(
            future: Future.wait([c.getPresensiData()]),
            builder: (context, AsyncSnapshot snap) {
              if (!snap.hasData) {
                return LoadingView();
              }
              List<PresensiModel> presensiData = snap.data[0];
              // List<LiburModel> liburData = snap.data[1];
              return SfCalendar(
                view: CalendarView.month,
                controller: CalendarController(),
                // dataSource: PresensiDataSource(presensiData, liburData),
                todayHighlightColor: Colors.blue,
                cellBorderColor: Colors.grey.shade200,
                appointmentTextStyle: TextStyle(color: Colors.white),

                monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                  showTrailingAndLeadingDates: true,
                ),
                selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.blue)),
              );
            }),
      );
    });
  }
}
