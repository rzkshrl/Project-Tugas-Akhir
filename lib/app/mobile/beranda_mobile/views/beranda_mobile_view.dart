// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../controller/auth_controller.dart';
import '../controllers/beranda_mobile_controller.dart';

class BerandaMobileView extends GetView<BerandaMobileController> {
  const BerandaMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final controller = Get.put(BerandaMobileController());

    String? nama = authC.userData.value.name;
    List<String> namaSplit = nama!.split(' ');
    String namaDisplay = namaSplit[0];
    String? email = authC.userData.value.email;
    String? bidang = authC.userData.value.bidang;
    String? profile = authC.userData.value.photoUrl;

    var defaultImage =
        "https://ui-avatars.com/api/?name=${nama}&background=fff38a&color=5175c0&font-size=0.33";
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
                    child: ClipOval(
                      child: Container(
                        width: 40.w,
                        height: 18.5.h,
                        color: Colors.grey.shade200,
                        child: Image.network(
                          profile != null
                              ? profile != ''
                                  ? profile
                                  : defaultImage
                              : defaultImage,
                          fit: BoxFit.cover,
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
                        style: getTextSemiHeaderWelcomeScreen(context, 15),
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
                        style: getTextSemiHeaderWelcomeScreen(context, 17),
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
              SfCircularChart(
                legend: Legend(isVisible: true),
                series: <CircularSeries>[
                  DoughnutSeries<Attendance, String>(
                    dataSource: controller.attendanceData,
                    xValueMapper: (Attendance data, _) => data.category,
                    yValueMapper: (Attendance data, _) => data.percentage,
                    dataLabelMapper: (Attendance data, _) =>
                        data.label, // Keterangan grafik
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
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
                      'Persentase Kehadiran Bulan April',
                      style: getTextSemiBoldHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      '95%',
                      style: getTextSubHeaderWelcomeScreen(context, 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 9.5.h,
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 5.w, left: 5.w),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Riwayat Presensi 5 Hari terakhir',
              //         style: getTextSemiBoldHeaderWelcomeScreen(context, 15),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 1.5.h,
              // ),
              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: 5,
              //     padding: EdgeInsets.only(top: 1.h),
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: EdgeInsets.only(bottom: 2.h),
              //         child: Container(
              //           height: 11.h,
              //           decoration: BoxDecoration(
              //               border: Border.all(color: Blue1),
              //               borderRadius: BorderRadius.circular(20)),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Text(
              //                         'Masuk',
              //                         style: getTextSemiBoldHeaderWelcomeScreen(
              //                             context, 15),
              //                       ),
              //                       SizedBox(
              //                         height: 1.h,
              //                       ),
              //                       Text(
              //                         '08.15.25',
              //                         style: getTextSubHeaderWelcomeScreen(
              //                             context, 15),
              //                       )
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     width: 5.5.w,
              //                   ),
              //                   Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Text(
              //                         'Keluar',
              //                         style: getTextSemiBoldHeaderWelcomeScreen(
              //                             context, 15),
              //                       ),
              //                       SizedBox(
              //                         height: 1.h,
              //                       ),
              //                       Text(
              //                         '13.02.15',
              //                         style: getTextSubHeaderWelcomeScreen(
              //                             context, 15),
              //                       )
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //               Column(
              //                 children: [
              //                   SizedBox(
              //                     height: 1.h,
              //                   ),
              //                   Text(
              //                     '10 Februari 2022',
              //                     style: getTextSubHeaderWelcomeScreen(
              //                         context, 15),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     })
            ],
          ),
        ));
  }
}

class Attendance {
  final String category;
  final double percentage;
  final String label;

  Attendance(this.category, this.percentage, this.label);
}
