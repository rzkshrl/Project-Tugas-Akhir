// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/usermodel.dart';
import 'package:project_tugas_akhir/app/utils/stringGlobal.dart';

import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';

class SuperAdminController extends GetxController {
  late Stream<List<UserModel>> firestoreUserList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  List<String> itemRoleUser = [admin, superAdmin, pegawai];
  final itemRoleView = ['Admin', 'Super-Admin', 'Pegawai'];

  @override
  void onInit() {
    super.onInit();

    firestoreUserList = firestore.collection('Users').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) => UserModel.fromJson(documentSnapshot))
            .toList());
  }

  Future<UserCredential> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();
      return userCredential;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<void> addUser(String nama, String role, String jabatan, String email,
      String pass, String pin) async {
    try {
      CollectionReference pegawai = firestore.collection("Users");

      final DocumentReference docRef = pegawai.doc(email);
      final checkData = await docRef.get();

      if (checkData.exists == false) {
        UserCredential user = await createUser(email, pass);

        Get.back();

        String uid = user.user?.uid ?? '';

        User? userNow = await auth
            .authStateChanges()
            .firstWhere((user) => user?.uid == uid);

        if (userNow != null) {
          await userNow.updateDisplayName(nama);
        }

        await pegawai.doc(email).set({
          'uid': uid,
          'name': nama,
          'email': email,
          'role': role,
          'bidang': jabatan,
          'pin': pin,
          'profile': '',
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
            IconlyLight.danger, "User sudah ada.", getTextAlert(Get.context!)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> editUser(String docIdentify, String uid, String nama,
      String role, String jabatan, String email, String pin) async {
    CollectionReference pegawai = firestore.collection("Users");

    if (kDebugMode) {
      print(uid);
    }

    User? user =
        await auth.authStateChanges().firstWhere((user) => user?.uid == uid);

    if (user != null) {
      await user.updateEmail(email);
      await user.updateDisplayName(nama);
    }

    await pegawai.doc(docIdentify).update({
      'name': nama,
      'email': email,
      'role': role,
      'bidang': jabatan,
      'pin': pin
    });
    Get.dialog(
      dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
          'Berhasil Mengubah User!', getTextAlert(Get.context!), () {
        Get.back();
      }),
    );
  }

  Future<void> deleteDoc(String doc, String uid) async {
    Get.dialog(dialogAlertDualBtn(() async {
      Get.back();
    }, () async {
      Get.back();
      try {
        if (kDebugMode) {
          print(uid);
        }
        User? user = await auth
            .authStateChanges()
            .firstWhere((user) => user?.uid == uid);
        if (user != null) {
          await user.delete();
        }
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
