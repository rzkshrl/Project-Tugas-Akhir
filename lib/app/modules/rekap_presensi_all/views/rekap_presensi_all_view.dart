import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/api_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/appBar.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/loading.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/rekap_presensi_all_controller.dart';

import 'package:http/http.dart' as http;

class RekapPresensiAllView extends GetView<RekapPresensiAllController> {
  const RekapPresensiAllView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final apiC = Get.put(APIController(context1: context));
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rekapitulasi Presensi Semua Pegawai',
                    style: getTextHeader(context),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'November 2022',
                        style: getTextSubHeader(context),
                      ),
                      Text(
                        ' / ',
                        style: getTextSubHeader(context),
                      ),
                      Text(
                        'Februari 2023',
                        style: getTextSubHeader(context),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    btnDefaultIcon1(13.w, Blue1, IconlyLight.swap, Yellow1,
                        "Refresh Data", getTextBtnAction(context), () {
                      apiC.getAllPresenceData(context);
                    }),
                    SizedBox(
                      width: 1.5.w,
                    ),
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
                child: SingleChildScrollView(
                    // child: PaginatedDataTable2(
                    //   columns: [
                    //     DataColumn(label: Text("PIN")),
                    //     DataColumn(label: Text('Scan Date'))
                    //   ],
                    //   source: dataScanlog,
                    //   rowsPerPage: controller.rowPerPage.value,
                    //   onRowsPerPageChanged: (index) {
                    //     controller.rowPerPage.value = index!;
                    //   },
                    // ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
