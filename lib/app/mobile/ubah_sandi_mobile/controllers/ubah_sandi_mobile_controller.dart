// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';

class UbahSandiMobileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final authC = Get.put(AuthController());

  void ubahSandi(String sandiLama, String sandiBaru) async {
    if (sandiLama == sandiBaru) {
      Get.dialog(dialogAlertOnlyAnimationMobile(
          'assets/lootie/warning.json',
          "Terjadi Kesalahan!",
          "Kata sandi tidak boleh sama!",
          getTextAlertMobile(Get.context!),
          getTextAlertSubMobile(Get.context!)));
    } else {
      try {
        String emailUser = auth.currentUser!.email!;
        await auth.signInWithEmailAndPassword(
            email: emailUser, password: sandiLama);
        await auth.currentUser!.updatePassword(sandiBaru);

        Get.dialog(
          dialogAlertBtnSingleMsgAnimationMobile(
              'assets/lootie/finish.json',
              'Berhasil Mengganti Kata Sandi!\nUser akan logout.',
              getTextAlert(Get.context!), () {
            authC.logout();
          }),
        );
        await auth.signInWithEmailAndPassword(
            email: emailUser, password: sandiBaru);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlySingleMsgAnimationMobile(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan!.",
            getTextAlert(Get.context!)));
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
