import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/usermodel.dart';

import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';

class SuperAdminController extends GetxController {
  late Stream<List<UserModel>> firestoreUserList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> itemRoleUser = ['admin', 'super-admin', 'pegawai'];
  final itemRoleView = ['Admin', 'Super-Admin', 'Pegawai'];

  @override
  void onInit() {
    super.onInit();
    firestoreUserList = firestore.collection('Users').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) => UserModel.fromJson(documentSnapshot))
            .toList());
  }

  Future<void> addUser(BuildContext context, String nama, String role,
      String jabatan, String email, String pass) async {
    try {
      CollectionReference pegawai = firestore.collection("Users");

      final DocumentReference docRef = pegawai.doc(email);
      final checkData = await docRef.get();

      if (checkData.exists == false) {
        UserCredential user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );

        String uid = user.user?.uid ?? '';
        await pegawai.doc(email).set({
          'uid': uid,
          'name': nama,
          'email': email,
          'role': role,
          'bidang': jabatan,
          'profile': '',
          'password': pass,
          'lastSignInDate': '',
          'creationTime': DateTime.now().toIso8601String(),
        });
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation(
              'assets/lootie/finish.json',
              'Berhasil Menambahkan User Baru!',
              getTextAlert(Get.context!), () {
            Get.back();
          }),
        );
      } else {
        Get.dialog(dialogAlertOnlySingleMsg(
            IconlyLight.danger, "User sudah ada.", getTextAlert(context)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> editUser(String docIdentify, BuildContext context, String nama,
      String role, String jabatan, String email, String pass) async {
    CollectionReference pegawai = firestore.collection("Users");

    await pegawai.doc(docIdentify).update({
      'name': nama,
      'email': email,
      'role': role,
      'bidang': jabatan,
      'password': pass,
    });
    Get.dialog(
      dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
          'Berhasil Mengubah User!', getTextAlert(Get.context!), () {
        Get.back();
      }),
    );
  }

  Future<void> deleteDoc(String doc) async {
    Get.dialog(dialogAlertDualBtn(() async {
      Get.back();
    }, () async {
      Get.back();
      try {
        await firestore.collection('Users').doc(doc).delete();
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menghapus Data!', getTextAlert(Get.context!), () {
            Get.back();
          }),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
      }
    },
        IconlyLight.danger,
        111.29,
        'Batal',
        111.29,
        'OK',
        'Peringatan!',
        'Apakah anda yakin ingin menghapus data?',
        getTextAlert(Get.context!),
        getTextAlertSub(Get.context!),
        getTextAlertBtn(Get.context!),
        getTextAlertBtn2(Get.context!)));
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
