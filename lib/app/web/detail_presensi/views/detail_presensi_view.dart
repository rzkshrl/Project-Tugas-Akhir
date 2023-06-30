import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:monitorpresensi/app/controller/calendars_controller.dart';
import 'package:monitorpresensi/app/data/models/firestorepengecualianmodel.dart';
import 'package:monitorpresensi/app/data/models/firestorescanlogmodel.dart';
import 'package:monitorpresensi/app/utils/fungsiRekap.dart';
import 'package:monitorpresensi/app/utils/loading.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/firestorehariliburmodel.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../hari_libur/controllers/hari_libur_controller.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../../pengecualian/controllers/pengecualian_controller.dart';
import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  const DetailPresensiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    String pin = data;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final authC = Get.put(AuthController());
    final c = Get.put(CalendarsController(pin));
    final liburC = Get.put(HariLiburController());
    final pengecualianC = Get.put(PengecualianController());
    // final CalendarController calendarController = Get.put(CalendarController());

    if (kDebugMode) {
      print(pin);
    }

    return FutureBuilder(
        future: simulateDelay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan LoadingWidget selama delay
            return const LoadingView();
          }
          return Scaffold(
            backgroundColor: light,
            drawer: const NavigationDrawerView(),
            drawerScrimColor: light.withOpacity(0.6),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: AppBar(
                backgroundColor: light,
                automaticallyImplyLeading: false,
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: null,
                title: Padding(
                  padding: EdgeInsets.only(
                    left: 1.5.w,
                    top: 26,
                  ),
                  child: Builder(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            iconSize: 30,
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            tooltip: MaterialLocalizations.of(context)
                                .openAppDrawerTooltip,
                            icon: FaIcon(
                              FontAwesomeIcons.bars,
                              color: Blue1,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 1.5.w,
                          ),
                          child: IconButton(
                            color: Blue1,
                            onPressed: () => authC.logout(),
                            icon: const Icon(IconlyLight.logout),
                            iconSize: 30,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 4.w, top: 2.h, right: 4.w, bottom: 8.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Presensi',
                          style: getTextHeader2(context),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Blue1.withOpacity(0.2)),
                      width: 70.w,
                      height: 75.h,
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
                            final List<PresensiModel> presensiList = snap
                                .data!.docs
                                .map((e) => PresensiModel.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList();

                            if (presensiList.isEmpty) {
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset('assets/lootie/no_data.json',
                                        height: 145),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'Data kosong.',
                                      style: getTextSubHeader(context),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return StreamBuilder(
                                stream: liburC.firestoreHolidayList,
                                builder: (context, snap) {
                                  if (!snap.hasData) {
                                    return const LoadingView();
                                  }
                                  final holidayList =
                                      snap.data! as List<HolidayModel>;

                                  return StreamBuilder(
                                      stream: pengecualianC
                                          .firestorePengecualianList,
                                      builder: (context, snap) {
                                        if (!snap.hasData) {
                                          return const LoadingView();
                                        }
                                        final pengecualianList = snap.data!
                                            as List<PengecualianModel>;

                                        List<PengecualianIterableModel>
                                            pengecualianRangeList = [];

                                        var pengecualian = pengecualianList
                                            .firstWhere((pengecualian) =>
                                                pengecualian
                                                    .statusPengecualian ==
                                                'Ya');

                                        generateDateRangePengecualian(
                                            pengecualianRangeList,
                                            pengecualian);
                                        return Column(
                                          children: [
                                            Expanded(
                                              child: SfCalendar(
                                                view: CalendarView.month,
                                                viewHeaderStyle:
                                                    ViewHeaderStyle(
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
                                                  showTrailingAndLeadingDates:
                                                      true,
                                                  showAgenda: true,
                                                  agendaViewHeight: 140,
                                                ),
                                                selectionDecoration:
                                                    BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        border: Border.all(
                                                            color: Blue1)),
                                                dataSource: _PresensiDataSource(
                                                    presensiList,
                                                    holidayList,
                                                    pengecualianList),
                                                monthCellBuilder: (BuildContext
                                                        context,
                                                    MonthCellDetails details) {
                                                  final DateTime date =
                                                      details.date;
                                                  final bool isLeadingDate =
                                                      details.visibleDates[0]
                                                                  .month ==
                                                              date.month &&
                                                          details
                                                                  .visibleDates[
                                                                      0]
                                                                  .year ==
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
                                                  final bool isToday = date
                                                              .year ==
                                                          DateTime.now().year &&
                                                      date.month ==
                                                          DateTime.now()
                                                              .month &&
                                                      date.day ==
                                                          DateTime.now().day;

                                                  final bool isHoliday =
                                                      holidayList.any((data) =>
                                                          DateTime.parse(data
                                                                      .date!)
                                                                  .year ==
                                                              date.year &&
                                                          DateTime.parse(data
                                                                      .date!)
                                                                  .month ==
                                                              date.month &&
                                                          DateTime.parse(data
                                                                      .date!)
                                                                  .day ==
                                                              date.day);

                                                  final bool isHolidayRutin =
                                                      pengecualianRangeList.any(
                                                          (data) =>
                                                              data.date!.year ==
                                                                  date.year &&
                                                              data.date!
                                                                      .month ==
                                                                  date.month &&
                                                              data.date!.day ==
                                                                  date.day);
                                                  if (details.date.weekday ==
                                                      7) {
                                                    return Center(
                                                      child: Text(
                                                          date.day.toString(),
                                                          style:
                                                              getTextCalendarHoliday(
                                                                  context)),
                                                    );
                                                  } else if (isHoliday) {
                                                    return Center(
                                                      child: Text(
                                                          date.day.toString(),
                                                          style:
                                                              getTextCalendarHoliday(
                                                                  context)),
                                                    );
                                                  } else if (isHolidayRutin) {
                                                    return Center(
                                                      child: Text(
                                                          date.day.toString(),
                                                          style:
                                                              getTextCalendarHolidayRutin(
                                                                  context)),
                                                    );
                                                  } else if (isLeadingDate ||
                                                      isTrailingDate) {
                                                    return Center(
                                                      child: Text(
                                                          date.day.toString(),
                                                          style:
                                                              getTextCalendarTrail(
                                                                  context)),
                                                    );
                                                  } else {
                                                    return Container(
                                                      decoration: isToday
                                                          ? BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
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
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _PresensiDataSource extends CalendarDataSource {
  final List<PresensiModel> presensiData;
  final List<HolidayModel> liburData;
  final List<PengecualianModel> pengecualianData;

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

    // print('$appointments');
    return appointments;
  }

  List<CalendarEvent> get events => [];

  @override
  DateTime getStartTime(int index) => presensiData[index].dateTime!;

  @override
  DateTime getEndTime(int index) =>
      presensiData[index].dateTime!.add(const Duration(minutes: 1));

  @override
  String getSubject(int index) => presensiData[index].status!;

  int getCount() => presensiData.length;

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
