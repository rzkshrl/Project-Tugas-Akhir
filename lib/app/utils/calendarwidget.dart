import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorpresensi/app/controller/calendars_controller.dart';
import 'package:monitorpresensi/app/utils/loading.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarsController>(builder: (c) {
      return SafeArea(
        child: FutureBuilder(
            future: Future.wait([c.getPresensiData()]),
            builder: (context, AsyncSnapshot snap) {
              if (!snap.hasData) {
                return const LoadingView();
              }
              // List<LiburModel> liburData = snap.data[1];
              return SfCalendar(
                view: CalendarView.month,
                controller: CalendarController(),
                // dataSource: PresensiDataSource(presensiData, liburData),
                todayHighlightColor: Colors.blue,
                cellBorderColor: Colors.grey.shade200,
                appointmentTextStyle: const TextStyle(color: Colors.white),

                monthViewSettings: const MonthViewSettings(
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
