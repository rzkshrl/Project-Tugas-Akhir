import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';

import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/textfield.dart';

class UbahProfilMobileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    var status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
      if (image != null) {
        print(image!.name);
        print(image!.name.split(".").last);
        print(image!.path);
      } else {
        print(image);
      }
      update();
    } else if (status == PermissionStatus.denied) {
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Akses ke penyimpanan ditolak!.", getTextAlert(Get.context!)));
    } else {
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Akses ke penyimpanan ditolak!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> ubahProfil(String nama, String bidang) async {
    String email = auth.currentUser!.email.toString();
    DocumentReference docUsers = firestore.collection("Users").doc(email);
    try {
      if (image != null) {
        File file = File(image!.path);
        String ext = image!.name.split(".").last;

        await storage.ref('$email/profile.$ext').putFile(file);
        String urlImage =
            await storage.ref('$email/profile.$ext').getDownloadURL();

        await docUsers
            .update({'name': nama, 'bidang': bidang, 'profile': urlImage});
        Get.dialog(
          dialogAlertBtnSingleMsgAnimationMobile('assets/lootie/finish.json',
              'Berhasil Menambahkan Data!', getTextAlert(Get.context!), () {
            Get.back();
          }),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    textC.namaTambahDataPegC.dispose();
    cDropdown.bidangUbahProfilC.dispose();
  }
}
