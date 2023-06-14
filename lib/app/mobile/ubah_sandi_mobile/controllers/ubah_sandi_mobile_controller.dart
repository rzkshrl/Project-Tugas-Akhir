// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';

class UbahSandiMobileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void ubahSandi(String sandiLama, String sandiBaru) async {
    if (sandiLama == sandiBaru) {
      Get.dialog(dialogAlertOnly(
          IconlyLight.danger,
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
          dialogAlertBtnSingleMsgAnimationMobile('assets/lootie/finish.json',
              'Berhasil Mengganti Kata Sandi!', getTextAlert(Get.context!), () {
            auth.signOut();
            Get.back();
            Get.back();
          }),
        );
        await auth.signInWithEmailAndPassword(
            email: emailUser, password: sandiBaru);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
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
