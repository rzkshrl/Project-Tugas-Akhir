import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/usermodel.dart';
import 'package:project_tugas_akhir/app/modules/profile_mobile/views/profile_mobile_view.dart';
import 'package:project_tugas_akhir/app/modules/riwayat_presensi/views/riwayat_presensi_view.dart';
import 'package:project_tugas_akhir/app/modules/riwayat_presensi_mobile/views/riwayat_presensi_mobile_view.dart';
import 'package:project_tugas_akhir/app/routes/app_pages.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/api_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/loading.dart';
import '../../beranda_mobile/views/beranda_mobile_view.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final apiC = Get.put(APIController(context1: context));
    if (kIsWeb) {
      // return FutureBuilder<DocumentSnapshot<Object?>>(
      //     future: authC.role(),
      //     builder: (context, snap) {
      //       if (snap.connectionState == ConnectionState.waiting) {
      //         return const LoadingView();
      //       }
      //       if (snap.hasData) {
      //         var role = snap.data!.get("role");
      //         if (role != "admin") {
      String? roles = authC.userData.value.role;
      print("ROLES : $roles");

      if (roles == null) {
        return Scaffold(
          backgroundColor: error.withOpacity(0.5),
          body: dialogAlertBtn(() {
            authC.logout();
          },
              IconlyLight.danger,
              111.29,
              "Keluar",
              "Terjadi Masalah!",
              "Silahkan masuk ulang.",
              getTextAlert(context),
              getTextAlertSub(context),
              getTextAlertBtn(context)),
        );
      } else {
        if (roles != "admin") {
          return Scaffold(
            backgroundColor: error.withOpacity(0.5),
            body: dialogAlertBtn(() {
              authC.logout();
            },
                IconlyLight.danger,
                111.29,
                "Keluar",
                "Salah Akun!",
                "Akun bukan admin, \nsilahkan masuk menggunakan akun admin.",
                getTextAlert(context),
                getTextAlertSub(context),
                getTextAlertBtn(context)),
          );
        } else {
          // return Routes.RIWAYAT_PRESENSI as Widget;
          // return Get.toNamed(RIWAYAT_PRESENSI) as Widget;
          // return Get.toNamed(Routes.RIWAYAT_PRESENSI) as Widget;
          return FutureBuilder(
              future: apiC.getDeviceInfo(context),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return LoadingView();
                }

                return FutureBuilder(
                    future: apiC.deviceData.value.allPresensi == null
                        ? Future.delayed(Duration(milliseconds: 0))
                        : Future.delayed(Duration(seconds: 3)),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return LoadingView();
                      }
                      return RiwayatPresensiView();
                    });
              });
        }
      }

      //   } else {
      //     return const LoadingView();
      //   }
      // });
    } else {
      final authC = Get.put(AuthController());
      var pages = <Widget>[
        BerandaMobileView(),
        RiwayatPresensiMobileView(),
        ProfileMobileView()
      ];
      return Scaffold(
        body: Obx(() => pages[controller.currentIndex.value]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Blue1,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 9.w, left: 9.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                navBarItem(context, IconlyLight.home, 0),
                navBarItem(context, FontAwesomeIcons.fingerprint, 1),
                navBarItem(context, IconlyLight.profile, 2),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget navBarItem(BuildContext context, IconData icon, int index) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          controller.changePage(index);
        },
        child: SizedBox(
          height: 75,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(11.0),
              child: SizedBox(
                width: 55,
                child: Icon(
                  icon,
                  color: (index == controller.currentIndex.value ||
                          Get.currentRoute == Routes.BERANDA_MOBILE)
                      ? light
                      : light.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ));
  }
}
