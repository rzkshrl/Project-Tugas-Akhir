// ignore_for_file: unnecessary_overrides, unused_import

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:monitorpresensi/app/theme/theme.dart';
import 'package:monitorpresensi/app/utils/dropdownTextField.dart';

import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/textfield.dart';

class UbahProfilMobileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();
  final authC = Get.put(AuthController());

  XFile? image;

  void pickImage() async {
    var status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      var pickedImage =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
      if (pickedImage != null) {
        var croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Potong Gambar',
                toolbarColor: Blue1,
                toolbarWidgetColor: light,
                backgroundColor: light,
                statusBarColor: dark),
          ],
        );
        if (croppedImage != null) {
          image = XFile.fromData(await croppedImage.readAsBytes(),
              path: croppedImage.path);
          if (kDebugMode) {
            print(image!.name);
            print(image!.path);
          }
        } else {
          if (kDebugMode) {
            print("Image cropping cancelled");
          }
        }
      } else {
        if (kDebugMode) {
          print(image);
        }
      }
      update();
    } else if (status == PermissionStatus.denied) {
      Get.dialog(dialogAlertOnlySingleMsgAnimationMobile(
          'assets/lootie/warning.json',
          "Akses ke penyimpanan ditolak!.",
          getTextAlertMobile(Get.context!)));
    } else {
      Get.dialog(dialogAlertOnlySingleMsgAnimationMobile(
          'assets/lootie/warning.json',
          "Akses ke penyimpanan ditolak!.",
          getTextAlertMobile(Get.context!)));
    }
  }

  showLoadingDialog() {
    Get.dialog(
      dialogAlertOnlySingleMsgAnimationMobile('assets/lootie/loading.json',
          'Memuat...', getTextAlertMobile(Get.context!)),
      barrierDismissible: false,
    );
  }

  Future<void> ubahProfil(String nama, String bidang) async {
    String email = auth.currentUser!.email.toString();
    DocumentReference<Map<String, dynamic>> docUsers =
        firestore.collection("Users").doc(email);
    var getDataFromUser = await docUsers.get();
    var getDataUser = getDataFromUser.data()!;
    DocumentReference<Map<String, dynamic>> docKepg =
        firestore.collection("Kepegawaian").doc(getDataUser['pin']);
    try {
      if (image != null) {
        File file = File(image!.path);
        String ext = image!.name.split(".").last;

        await storage.ref('$email/profile.$ext').putFile(file);
        String urlImage =
            await storage.ref('$email/profile.$ext').getDownloadURL();

        if (nama == '') {
          await docUsers.update({'profile': urlImage});
        } else {
          await docUsers.update({'name': nama, 'profile': urlImage});
          await docKepg.update({
            "nama": nama,
          });
        }

        await Get.dialog(
          dialogAlertBtnSingleMsgAnimationMobile('assets/lootie/finish.json',
              'Berhasil Mengubah Data!', getTextAlertMobile(Get.context!), () {
            Get.back();
            Get.back();
            Get.back();
          }),
        );
      } else {
        await docUsers.update({
          'name': nama,
        });
        await docKepg.update({
          "nama": nama,
        });

        await Get.dialog(
          dialogAlertBtnSingleMsgAnimationMobile('assets/lootie/finish.json',
              'Berhasil Mengubah Data!.', getTextAlertMobile(Get.context!), () {
            Get.back();
            Get.back();
            Get.back();
          }),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsgAnimationMobile(
          'assets/lootie/warning.json',
          "Terjadi Kesalahan!.",
          getTextAlertMobile(Get.context!)));
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
  }
}
