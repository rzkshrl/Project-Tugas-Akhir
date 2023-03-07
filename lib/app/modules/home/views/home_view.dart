import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/modules/riwayat_presensi/views/riwayat_presensi_view.dart';
import 'package:project_tugas_akhir/app/routes/app_pages.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/loading.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    if (kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows)) {
      // return FutureBuilder<DocumentSnapshot<Object?>>(
      //     future: authC.role(),
      //     builder: (context, snap) {
      //       if (snap.connectionState == ConnectionState.waiting) {
      //         return const LoadingView();
      //       }
      //       if (snap.hasData) {
      //         var role = snap.data!.get("role");
      //         if (role != "admin") {
      if (authC.userData.value.role != "admin") {
        return const RiwayatPresensiView();
      } else {
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
      }
      //   } else {
      //     return const LoadingView();
      //   }
      // });
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'HALO Ini MOBILE',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
}
