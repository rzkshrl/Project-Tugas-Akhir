import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/calendars_controller.dart';
import '../../../data/models/firestorehariliburmodel.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/loading.dart';
import '../../../web/hari_libur/controllers/hari_libur_controller.dart';
import '../controllers/riwayat_presensi_mobile_controller.dart';

class RiwayatPresensiMobileView
    extends GetView<RiwayatPresensiMobileController> {
  const RiwayatPresensiMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    String? pin = authC.userData.value.pin;
    if (kDebugMode) {
      (pin);
    }
    final c = Get.put(CalendarsController(pin));
    final controller = Get.put(RiwayatPresensiMobileController());
    final liburC = Get.put(HariLiburController());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: light,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(right: 6.w, left: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w, left: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Riwayat Presensi',
                      style: getTextHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      'Detail Riwayat Presensi Anda',
                      style: getTextSubHeaderWelcomeScreen(context, 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Blue1.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18)),
                height: 55.h,
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('Kepegawaian')
                        .doc(pin)
                        .collection('Presensi')
                        .orderBy("date_time", descending: false)
                        .snapshots(),
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return const LoadingView();
                      }
                      final List<PresensiModel> presensiList = snap.data!.docs
                          .map((e) => PresensiModel.fromJson(
                              e.data() as Map<String, dynamic>))
                          .toList();
                      return StreamBuilder(
                          stream: liburC.firestoreHolidayList,
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return const LoadingView();
                            }
                            final holidayList =
                                snap.data! as List<HolidayModel>;

                            return Column(
                              children: [
                                Expanded(
                                  child: SfCalendar(
                                    view: CalendarView.month,
                                    viewHeaderStyle:
                                        ViewHeaderStyle(backgroundColor: light),
                                    controller: c.controller,
                                    todayHighlightColor: Blue1,
                                    cellBorderColor: Grey1,
                                    showNavigationArrow: true,
                                    showDatePickerButton: true,
                                    allowedViews: const [
                                      CalendarView.month,
                                      CalendarView.day,
                                      CalendarView.week,
                                    ],
                                    appointmentTextStyle:
                                        c.appointmentTextStyle,
                                    monthViewSettings: const MonthViewSettings(
                                      dayFormat: 'EEE',
                                      appointmentDisplayMode:
                                          MonthAppointmentDisplayMode.indicator,
                                      showTrailingAndLeadingDates: true,
                                      showAgenda: true,
                                      agendaViewHeight: 140,
                                    ),
                                    selectionDecoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: Blue1)),
                                    dataSource: _PresensiDataSource(
                                        presensiList, holidayList),
                                    monthCellBuilder: (BuildContext context,
                                        MonthCellDetails details) {
                                      final DateTime date = details.date;
                                      final bool isLeadingDate =
                                          details.visibleDates[0].month ==
                                                  date.month &&
                                              details.visibleDates[0].year ==
                                                  date.year;
                                      final bool isTrailingDate = details
                                                  .visibleDates[details
                                                          .visibleDates.length -
                                                      1]
                                                  .month ==
                                              date.month &&
                                          details
                                                  .visibleDates[details
                                                          .visibleDates.length -
                                                      1]
                                                  .year ==
                                              date.year;
                                      final bool isToday = date.year ==
                                              DateTime.now().year &&
                                          date.month == DateTime.now().month &&
                                          date.day == DateTime.now().day;

                                      final bool isHoliday = holidayList.any(
                                          (data) =>
                                              DateTime.parse(data.date!).year ==
                                                  date.year &&
                                              DateTime.parse(data.date!)
                                                      .month ==
                                                  date.month &&
                                              DateTime.parse(data.date!).day ==
                                                  date.day);
                                      if (isLeadingDate || isTrailingDate) {
                                        return Center(
                                          child: Text(date.day.toString(),
                                              style: getTextCalendarTrail(
                                                  context)),
                                        );
                                      } else if (isHoliday) {
                                        return Center(
                                          child: Text(date.day.toString(),
                                              style: getTextCalendarHoliday(
                                                  context)),
                                        );
                                      } else if (details.date.weekday == 7) {
                                        return Center(
                                          child: Text(date.day.toString(),
                                              style: getTextCalendarHoliday(
                                                  context)),
                                        );
                                      } else {
                                        return Container(
                                          decoration: isToday
                                              ? BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Blue1,
                                                )
                                              : null,
                                          child: Center(
                                            child: Text(date.day.toString(),
                                                style: isToday
                                                    ? getTextCalendarToday(
                                                        context)
                                                    : getTextCalendarDef(
                                                        context)),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          });
                    }),
              )
            ],
          ),
        ));
  }
}

class _PresensiDataSource extends CalendarDataSource {
  final List<PresensiModel> presensiData;

  final List<HolidayModel> liburData;

  _PresensiDataSource(this.presensiData, this.liburData);

  @override
  List<Appointment> get appointments => getAppointments();

  List<Appointment> getAppointments() {
    final List<Appointment> appointments = [];

    for (final dataLibur in liburData) {
      final DateTime dateTimeLibur = DateTime.parse(dataLibur.date!);
      final String name = dataLibur.name!;

      appointments.add(Appointment(
        startTime: dateTimeLibur,
        endTime: dateTimeLibur,
        subject: name,
        color: error,
        isAllDay: true,
      ));
    }

    for (final data in presensiData) {
      final DateTime? dateTime = data.dateTime;
      final String status = data.status!;
      // print('ini status ${data.status}');

      if (dateTime != null) {
        if (status == 'Masuk') {
          appointments.add(Appointment(
            startTime: dateTime,
            endTime: dateTime,
            subject: 'Masuk',
            color: Colors.green,
          ));
        } else if (status == 'Keluar') {
          appointments.add(Appointment(
            startTime: dateTime,
            endTime: dateTime,
            subject: 'Keluar',
            color: Blue3,
          ));
        }
      } else {
        appointments.add(Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          subject: 'Tanpa Keterangan',
          color: Grey1,
        ));
      }
    }

    // for (final data in presensiData) {
    //   final DateTime? dateTimeMasuk = data.dateTimeMasuk!;
    //   final DateTime? dateTimeKeluar = data.dateTimeKeluar!;

    //   appointments.add(Appointment(
    //     startTime: dateTimeMasuk!,
    //     endTime: dateTimeKeluar!,
    //     subject: 'Hadir',
    //     color: Colors.green,
    //   ));
    // }

    // print('$appointments');
    return appointments;
  }

  // List<CalendarEvent> get events => [];

  // @override
  // DateTime getStartTime(int index) => presensiData[index].dateTimeMasuk!;

  // @override
  // DateTime getEndTime(int index) => presensiData[index].dateTimeKeluar!;

  // @override
  // String getSubject(int index) => presensiData[index].dateTimeMasuk! != null &&
  //         presensiData[index].dateTimeKeluar! != null
  //     ? "Hadir"
  //     : "Tanpa Keterangan";

  // int getCount() => presensiData.length;

  List<DateTime> get specialDates => _getSpecialDates();

  List<DateTime> _getSpecialDates() {
    final List<DateTime> specialDates = [];

    for (final data in liburData) {
      final DateTime dateTime = DateTime.parse(data.date!);

      specialDates.add(dateTime);
    }

    return specialDates;
  }

  List<DateTime> get blackoutDates => _getBlackoutDates();

  List<DateTime> _getBlackoutDates() {
    final List<DateTime> blackoutDates = [];

    for (final data in liburData) {
      final DateTime dateTime = DateTime.parse(data.date!);

      blackoutDates.add(dateTime);
    }

    return blackoutDates;
  }

  @override
  Color getColor(int index) => appointments[index].color;

  @override
  String getNotes(int index) => '';
}
