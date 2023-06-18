// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/calendars_controller.dart';
import '../../../data/models/firestorehariliburmodel.dart';
import '../../../data/models/firestorepengecualianmodel.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/fungsiRekap.dart';
import '../../../utils/loading.dart';
import '../../../web/hari_libur/controllers/hari_libur_controller.dart';
import '../../../web/pengecualian/controllers/pengecualian_controller.dart';
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
    final pengecualianC = Get.put(PengecualianController());
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
                child: FutureBuilder<QuerySnapshot>(
                    future: firestore
                        .collection('Kepegawaian')
                        .doc(pin)
                        .collection('Presensi')
                        .get(),
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

                            return StreamBuilder(
                                stream: pengecualianC.firestorePengecualianList,
                                builder: (context, snap) {
                                  if (!snap.hasData) {
                                    return const LoadingView();
                                  }
                                  final pengecualianList =
                                      snap.data! as List<PengecualianModel>;

                                  List<PengecualianIterableModel>
                                      pengecualianRangeList = [];

                                  var pengecualian = pengecualianList
                                      .firstWhere((pengecualian) =>
                                          pengecualian.statusPengecualian ==
                                          'Ya');

                                  generateDateRangePengecualian(
                                      pengecualianRangeList, pengecualian);
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SfCalendar(
                                          view: CalendarView.month,
                                          viewHeaderStyle: ViewHeaderStyle(
                                              backgroundColor: light),
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
                                          monthViewSettings:
                                              const MonthViewSettings(
                                            dayFormat: 'EEE',
                                            appointmentDisplayMode:
                                                MonthAppointmentDisplayMode
                                                    .indicator,
                                            showTrailingAndLeadingDates: true,
                                            showAgenda: true,
                                            agendaViewHeight: 140,
                                          ),
                                          selectionDecoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(color: Blue1)),
                                          dataSource: _PresensiDataSource(
                                              presensiList,
                                              holidayList,
                                              pengecualianList),
                                          onViewChanged:
                                              (ViewChangedDetails details) {
                                            DateTime? currentMonthStart =
                                                DateTime(
                                                    details
                                                        .visibleDates[0].year,
                                                    details.visibleDates[0]
                                                            .month +
                                                        1,
                                                    1);

                                            DateTime? currentMonthEnd =
                                                DateTime(
                                                    currentMonthStart.year,
                                                    currentMonthStart.month + 1,
                                                    0);

                                            if (kDebugMode) {
                                              print(currentMonthStart);
                                              print(currentMonthEnd);
                                            }

                                            controller.setCurrentMonth(
                                                currentMonthStart);

                                            if (currentMonthStart != null &&
                                                currentMonthEnd != null) {
                                              controller.getPercentagePresence(
                                                  currentMonthStart,
                                                  currentMonthEnd);
                                            }
                                          },
                                          monthCellBuilder:
                                              (BuildContext context,
                                                  MonthCellDetails details) {
                                            var date = details.date;

                                            final bool isLeadingDate = details
                                                        .visibleDates[0]
                                                        .month ==
                                                    date.month &&
                                                details.visibleDates[0].year ==
                                                    date.year;
                                            final bool isTrailingDate = details
                                                        .visibleDates[details
                                                                .visibleDates
                                                                .length -
                                                            1]
                                                        .month ==
                                                    date.month &&
                                                details
                                                        .visibleDates[details
                                                                .visibleDates
                                                                .length -
                                                            1]
                                                        .year ==
                                                    date.year;
                                            final bool isToday = date.year ==
                                                    DateTime.now().year &&
                                                date.month ==
                                                    DateTime.now().month &&
                                                date.day == DateTime.now().day;

                                            final bool isHoliday =
                                                holidayList.any((data) =>
                                                    DateTime.parse(data.date!)
                                                            .year ==
                                                        date.year &&
                                                    DateTime.parse(data.date!)
                                                            .month ==
                                                        date.month &&
                                                    DateTime.parse(data.date!)
                                                            .day ==
                                                        date.day);
                                            if (isLeadingDate ||
                                                isTrailingDate) {
                                              return Center(
                                                child: Text(date.day.toString(),
                                                    style: getTextCalendarTrail(
                                                        context)),
                                              );
                                            } else if (isHoliday) {
                                              return Center(
                                                child: Text(date.day.toString(),
                                                    style:
                                                        getTextCalendarHoliday(
                                                            context)),
                                              );
                                            } else if (details.date.weekday ==
                                                7) {
                                              return Center(
                                                child: Text(date.day.toString(),
                                                    style:
                                                        getTextCalendarHoliday(
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
                                                  child: Text(
                                                      date.day.toString(),
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
                          });
                    }),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              GetBuilder<RiwayatPresensiMobileController>(builder: (c) {
                return SafeArea(
                  child: Obx(
                    () => SfCircularChart(
                      title: ChartTitle(
                          text: 'Persentase Presensi',
                          textStyle:
                              getTextSemiBoldHeaderWelcomeScreen(context, 15)),
                      legend: Legend(isVisible: true),
                      series: <CircularSeries>[
                        DoughnutSeries<PercentageModel, String>(
                          dataSource: c.percentageList.value,
                          xValueMapper: (PercentageModel data, _) =>
                              data.category,
                          yValueMapper: (PercentageModel data, _) =>
                              data.percentage,
                          dataLabelMapper: (PercentageModel data, _) =>
                              '${data.percentage!.toStringAsFixed(1)}%', // Keterangan grafik
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 2.5.h,
              ),
              Center(
                child: Container(
                  height: 0.1.h,
                  width: 70.w,
                  decoration: BoxDecoration(color: Blue1.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Persentase Kehadiran Bulan ${controller.dateFormatter.format(controller.currentMonth.value)}',
                      style: getTextSemiBoldHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Obx(() {
                      final List<PercentageModel> percentageList =
                          controller.percentageList;

                      if (percentageList.isEmpty) {
                        return Text(
                          'Memuat...',
                          style: getTextSubHeaderWelcomeScreen(context, 16),
                        );
                      }

                      final String kehadiran = percentageList
                          .firstWhere((p) => p.category == 'Hadir')
                          .percentage!
                          .toStringAsFixed(1);

                      return Text(
                        '$kehadiran%',
                        style: getTextSubHeaderWelcomeScreen(context, 16),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Center(
                child: Container(
                  height: 0.1.h,
                  width: 70.w,
                  decoration: BoxDecoration(color: Blue1.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Persentase Ketidakhadiran Bulan ${controller.dateFormatter.format(controller.currentMonth.value)}',
                      style: getTextSemiBoldHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Obx(() {
                      final List<PercentageModel> percentageList =
                          controller.percentageList;

                      if (percentageList.isEmpty) {
                        return Text(
                          'Memuat...',
                          style: getTextSubHeaderWelcomeScreen(context, 16),
                        );
                      }

                      final String kehadiran = percentageList
                          .firstWhere((p) => p.category == 'Tidak Hadir')
                          .percentage!
                          .toStringAsFixed(1);

                      return Text(
                        '$kehadiran%',
                        style: getTextSubHeaderWelcomeScreen(context, 16),
                      );
                    }),
                    SizedBox(
                      height: 9.5.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _PresensiDataSource extends CalendarDataSource {
  final List<PresensiModel> presensiData;
  final List<PengecualianModel> pengecualianData;
  final List<HolidayModel> liburData;

  _PresensiDataSource(this.presensiData, this.liburData, this.pengecualianData);

  @override
  List<Appointment> get appointments => getAppointments();

  List<Appointment> getAppointments() {
    final List<Appointment> appointments = [];
    List<PengecualianIterableModel> pengecualianRangeList = [];

    var pengecualian = pengecualianData
        .firstWhere((pengecualian) => pengecualian.statusPengecualian == 'Ya');

    generateDateRangePengecualian(pengecualianRangeList, pengecualian);

    for (var dataLiburRutin in pengecualianRangeList) {
      final DateTime date = dataLiburRutin.date!;
      final String name = dataLiburRutin.nama!;

      appointments.add(Appointment(
        startTime: date,
        endTime: date,
        subject: name,
        color: redAppoint,
        isAllDay: true,
      ));
    }

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

    return appointments;
  }

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
