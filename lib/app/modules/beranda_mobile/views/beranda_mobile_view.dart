import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:sizer/sizer.dart';

import '../controllers/beranda_mobile_controller.dart';

class BerandaMobileView extends GetView<BerandaMobileController> {
  const BerandaMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var defaultImage =
        "https://ui-avatars.com/api/?background=fff38a&color=5175c0&font-size=0.33";
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
                      'Selamat Datang, Rizky',
                      style: getTextHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      'Pantau Presensi Anda secara Langsung',
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
                        width: 38.w,
                        color: Colors.grey.shade200,
                        child: Image.network(
                          defaultImage,
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
                        'Rizky Syahrul Mubarok',
                        style: getTextSemiHeaderWelcomeScreen(context, 15),
                      ),
                      SizedBox(
                        height: 3.3.h,
                      ),
                      Text(
                        'Guru Kelas',
                        style: getTextSubHeaderWelcomeScreen(context, 15),
                      ),
                      Text(
                        'rizkysahrul0@gmail.com',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Jam Presensi Masuk',
                        style: getTextSemiBoldHeaderWelcomeScreen(context, 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        '08:12:45',
                        style: getTextSubHeaderWelcomeScreen(context, 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        '10 Februari 2023',
                        style: getTextSubHeaderWelcomeScreen(context, 16),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Jam Presensi Keluar',
                        style: getTextSemiBoldHeaderWelcomeScreen(context, 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        '13:02:15',
                        style: getTextSubHeaderWelcomeScreen(context, 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        '10 Februari 2023',
                        style: getTextSubHeaderWelcomeScreen(context, 16),
                      )
                    ],
                  )
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
                      'Total Jam Kerja',
                      style: getTextSemiBoldHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      '05:10:30',
                      style: getTextSubHeaderWelcomeScreen(context, 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 9.5.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Riwayat Presensi 5 Hari terakhir',
                      style: getTextSemiBoldHeaderWelcomeScreen(context, 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  padding: EdgeInsets.only(top: 1.h),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Container(
                        height: 11.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Blue1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Masuk',
                                      style: getTextSemiBoldHeaderWelcomeScreen(
                                          context, 15),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      '08.15.25',
                                      style: getTextSubHeaderWelcomeScreen(
                                          context, 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 5.5.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Keluar',
                                      style: getTextSemiBoldHeaderWelcomeScreen(
                                          context, 15),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      '13.02.15',
                                      style: getTextSubHeaderWelcomeScreen(
                                          context, 15),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  '10 Februari 2022',
                                  style: getTextSubHeaderWelcomeScreen(
                                      context, 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
