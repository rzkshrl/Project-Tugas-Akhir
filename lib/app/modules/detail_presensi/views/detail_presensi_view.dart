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
                width: 90.w,
                height: 70.h,
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
                            return SfCalendar(
                              view: CalendarView.month,
                              todayHighlightColor: Colors.blue,
                              cellBorderColor: Colors.grey.shade200,
                              appointmentTextStyle:
                                  TextStyle(color: Colors.white),
                              monthViewSettings: MonthViewSettings(
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.appointment,
                                  showTrailingAndLeadingDates: true,
                                  showAgenda: true),
                              selectionDecoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.blue)),
                              dataSource: _PresensiDataSource(
                                  presensiList, holidayList),
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

    for (final data in presensiData) {
      final DateTime dateTime = data.dateTime!;
      final String status = data.status!;

      if (status == 'masuk') {
        appointments.add(Appointment(
          startTime: dateTime,
          endTime: dateTime.add(Duration(minutes: 1)),
          subject: 'Masuk',
          color: Colors.green,
        ));
      } else if (status == 'keluar') {
        appointments.add(Appointment(
          startTime: dateTime,
          endTime: dateTime.add(Duration(minutes: 1)),
          subject: 'Keluar',
          color: Colors.red,
        ));
      }
    }

    return appointments;
  }

  @override
  List<CalendarEvent> get events => [];

  @override
  DateTime getStartTime(int index) => presensiData[index].dateTime!;

  @override
  DateTime getEndTime(int index) =>
      presensiData[index].dateTime!.add(Duration(minutes: 1));

  @override
  String getSubject(int index) => presensiData[index].status!;

  @override
  int getCount() => presensiData.length;

  @override
  List<DateTime> get specialDates => _getSpecialDates();

  List<DateTime> _getSpecialDates() {
    final List<DateTime> specialDates = [];

    for (final data in liburData) {
      final DateTime dateTime = DateTime.parse(data.date!);

      specialDates.add(dateTime);
    }

    return specialDates;
  }

  @override
  Color getColor(int index) => Colors.transparent;

  @override
  String getNotes(int index) => '';
}
