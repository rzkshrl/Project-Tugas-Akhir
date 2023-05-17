import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/controller/calendars_controller.dart';
import 'package:project_tugas_akhir/app/data/models/firestorescanlogmodel.dart';
import 'package:project_tugas_akhir/app/utils/calendarwidget.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../controller/api_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../data/models/firestorehariliburmodel.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../hari_libur/controllers/hari_libur_controller.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
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
    final apiC = Get.put(APIController(context1: context));
    final CalendarController calendarController = Get.put(CalendarController());

    print(pin);
    return Scaffold(
      backgroundColor: light,
      drawer: const NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
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
                      icon: Icon(IconlyLight.logout),
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
          padding:
              EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w, bottom: 8.h),
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
              Padding(
                padding: EdgeInsets.only(right: 1.8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    textButton1(IconlyLight.calendar, Blue1, "Filter Tanggal",
                        getTextBtn(context), () {}),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                decoration: BoxDecoration(color: Blue1.withOpacity(0.2)),
                width: 70.w,
                height: 75.h,
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('Kepegawaian')
                        .doc(pin)
                        .collection('Presensi')
                        .snapshots(),
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return LoadingView();
                      }
                      final List<PresensiModel> presensiList = snap.data!.docs
                          .map((e) => PresensiModel.fromJson(
                              e.data() as Map<String, dynamic>))
                          .toList();
                      return StreamBuilder(
                          stream: liburC.firestoreHolidayList,
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return LoadingView();
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
                                    allowedViews: [
                                      CalendarView.month,
                                      CalendarView.day,
                                      CalendarView.week,
                                      CalendarView.workWeek,
                                      CalendarView.timelineDay,
                                      CalendarView.timelineWeek,
                                      CalendarView.timelineWorkWeek,
                                      CalendarView.timelineMonth,
                                    ],
                                    appointmentTextStyle:
                                        c.appointmentTextStyle,
                                    monthViewSettings: MonthViewSettings(
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
                                        return Container(
                                          child: Center(
                                            child: Text(date.day.toString(),
                                                style: getTextCalendarTrail(
                                                    context)),
                                          ),
                                        );
                                      } else if (isHoliday) {
                                        return Container(
                                          child: Center(
                                            child: Text(date.day.toString(),
                                                style: getTextCalendarHoliday(
                                                    context)),
                                          ),
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
                                // ListTile(
                                //   title: Text(c..subject),
                                //   subtitle: Text(
                                //       'Start: ${c.selectedAppointment.startTime.toString()}'),
                                //   // Tambahkan informasi lain yang diperlukan dari appointment
                                // )
                              ],
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
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
      final DateTime dateTime = data.dateTime!;
      final String status = data.status!;
      // print('ini status ${data.status}');

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
    }

    // print('$appointments');
    return appointments;
  }

  List<CalendarEvent> get events => [];

  @override
  DateTime getStartTime(int index) => presensiData[index].dateTime!;

  @override
  DateTime getEndTime(int index) =>
      presensiData[index].dateTime!.add(Duration(minutes: 1));

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