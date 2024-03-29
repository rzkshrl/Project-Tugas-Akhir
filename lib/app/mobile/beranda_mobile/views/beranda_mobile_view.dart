// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:monitorpresensi/app/theme/textstyle.dart';
import 'package:monitorpresensi/app/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/models/firestorescanlogmodel.dart';
import '../../profile_mobile/controllers/profile_mobile_controller.dart';
import '../controllers/beranda_mobile_controller.dart';

class BerandaMobileView extends GetView<BerandaMobileController> {
  const BerandaMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BerandaMobileController());
    controller.getPercentagePresence();
    final userC = Get.put(ProfileMobileController());

    return Scaffold(
        backgroundColor: light,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: userC.userNow(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Lottie.asset('assets/lootie/loading2.json',
                        height: 135));
              }
              var data = snap.data!.data()!;
              String nama = data['name'];
              List<String> namaSplit = nama.split(' ');
              String namaDisplay = namaSplit[0];
              var email = data['email'];
              var bidang = data['bidang'];
              var profile = data['profile'];
              var defaultImage =
                  "https://ui-avatars.com/api/?name=${nama}&background=fff38a&color=5175c0&font-size=0.33&size=256";
              return SingleChildScrollView(
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
                            'Selamat Datang, $namaDisplay',
                            style: getTextHeaderWelcomeScreen(context, 16),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Pantau Presensi Anda',
                            style: getTextSubHeaderWelcomeScreen(context, 15),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 3.w, left: 3.w),
                          child: InkWell(
                            onTap: () {
                              Get.dialog(
                                  Dialog(
                                    child: Image.network(
                                      profile != null
                                          ? profile != ''
                                              ? profile
                                              : defaultImage
                                          : defaultImage,
                                      // width: 45.w,
                                    ),
                                  ),
                                  barrierColor: light.withOpacity(0.65));
                            },
                            child: ClipOval(
                              child: Image.network(
                                profile != null
                                    ? profile != ''
                                        ? profile
                                        : defaultImage
                                    : defaultImage,
                                width: 35.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$nama',
                              style:
                                  getTextSemiHeaderWelcomeScreen(context, 15),
                            ),
                            SizedBox(
                              height: 3.3.h,
                            ),
                            Text(
                              '$bidang',
                              style: getTextSubHeaderWelcomeScreen(context, 15),
                            ),
                            Text(
                              '$email',
                              style: getTextSubHeaderWelcomeScreen(context, 15),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              '81214676130143321',
                              style:
                                  getTextSemiHeaderWelcomeScreen(context, 17),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Container(
                      height: 0.1.h,
                      decoration: BoxDecoration(color: Blue1.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    GetBuilder<BerandaMobileController>(builder: (c) {
                      return SafeArea(
                        child: Obx(
                          () => SfCircularChart(
                            title: ChartTitle(
                                text: 'Persentase Presensi Bulan Lalu',
                                textStyle: getTextSemiBoldHeaderWelcomeScreen(
                                    context, 15)),
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
                        decoration:
                            BoxDecoration(color: Blue1.withOpacity(0.5)),
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
                            'Persentase Kehadiran Bulan ${controller.dateFormatter.format(controller.previousMonth)}',
                            style:
                                getTextSemiBoldHeaderWelcomeScreen(context, 16),
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
                                style:
                                    getTextSubHeaderWelcomeScreen(context, 16),
                              );
                            }

                            final String kehadiran = percentageList
                                .firstWhere((p) => p.category == 'Hadir')
                                .percentage!
                                .toStringAsFixed(1);

                            return Text(
                              '${kehadiran}%',
                              style: getTextSubHeaderWelcomeScreen(context, 16),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 9.5.h,
                    ),
                  ],
                ),
              );
            }));
  }
}
