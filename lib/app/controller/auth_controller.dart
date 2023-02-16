import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';

import '../routes/app_pages.dart';
import '../utils/dialogDefault.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  final dialogC = Get.put(dialogDef());

  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.userChanges();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamDataUsers() {
    CollectionReference users = firestore.collection("Users");
    return users.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getUserDoc() async {
    String uid = auth.currentUser!.uid;
    DocumentReference user = firestore.collection("Users").doc(uid);
    return user.get();
  }

  Future<DocumentSnapshot<Object?>> role() async {
    String uid = auth.currentUser!.uid;
    DocumentReference users = firestore.collection('Users').doc(uid);
    return users.get();
  }

  //store user data
  void syncUsers(
    String email,
    String password,
  ) async {
    String uid = auth.currentUser!.uid.toString();

    CollectionReference users = firestore.collection('Users');
    try {
      users.doc(uid).set({
        'uid': uid,
        'email': email,
        'profile': '',
        'password': password,
        'role': "user",
      });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak Berhasil Memasukkan Data",
      );
    }
  }

  //lupa sandi
  void lupaSandi(String email, BuildContext context) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      Get.dialog(dialogC.dialogAlertBtn(() {
        Get.back();
      },
          IconlyLight.tick_square,
          111.29,
          "OK",
          "Email sukses terkirim!",
          "Cek inbox email Anda untuk reset sandi",
          getTextAlert(context),
          getTextAlertSub(context),
          getTextAlertBtn(context)));
    } catch (e) {
      Get.defaultDialog(
          title: 'Terjadi kesalahan',
          middleText: 'Tidak dapat mengirimkan reset password');
    }
  }

  //login
  void login(String email, String password, BuildContext context) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.RIWAYAT_PRESENSI);
      } else {
        Get.dialog(dialogC.dialogAlertDualBtn(() async {
          myUser.user!.sendEmailVerification();
          Get.back();
          await Get.dialog(dialogC.dialogAlertBtn(() {
            Get.back();
          },
              IconlyLight.tick_square,
              111.29,
              "OK",
              "Email sukses terkirim!",
              "Cek inbox email Anda",
              getTextAlert(context),
              getTextAlertSub(context),
              getTextAlertBtn(context)));
        }, () {
          Get.back();
        },
            IconlyLight.danger,
            111.29,
            "Kirim",
            111.29,
            "Batal",
            "Email Belum Diverifikasi!",
            "klik tombol Kirim untuk mengirim email verifikasi",
            getTextAlert(context),
            getTextAlertSub(context),
            getTextAlertBtn(context),
            getTextAlertBtn2(context)));

        // Get.dialog(dialogC.dialogAlert(() async {
        //   myUser.user!.sendEmailVerification();
        //   Get.back();
        //   await Get.dialog(dialogAlert(() {
        //     Get.back();
        //   },
        //       IconlyLight.tick_square,
        //       316,
        //       111.29,
        //       "OK",
        //       "Email sukses terkirim!",
        //       "Cek inbox email Anda",
        //       getTextAlert(context),
        //       getTextAlertSub(context),
        //       getTextAlertBtn(context)));
        // },
        //     IconlyLight.danger,
        //     316,
        //     111.29,
        //     "Kirim",
        //     "Email Belum Diverifikasi!",
        //     "klik tombol Kirim untuk mengirim email verifikasi",
        //     getTextAlert(context),
        //     getTextAlertSub(context),
        //     getTextAlertBtn(context)));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.dialog(dialogC.dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Akun tidak ditemukan!", getTextAlert(context)));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.dialog(dialogC.dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Kata sandi yang dimasukkan salah!", getTextAlert(context)));
      }
    } catch (e) {
      print(e);
      Get.dialog(dialogC.dialogAlertOnly(
          IconlyLight.danger,
          "Terjadi Kesalahan.",
          "Tidak dapat masuk.",
          getTextAlert(context),
          getTextAlertSub(context)));
    }
  }

  //register
  void register(String email, String password, BuildContext context) async {
    try {
      UserCredential myUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      syncUsers(email, password);
      await myUser.user!.sendEmailVerification();
      Get.dialog(dialogC.dialogAlertBtn(() {
        Get.back();
      },
          IconlyLight.tick_square,
          111.29,
          "OK",
          "Sukses daftar akun baru!",
          "Cek inbox email Anda untuk verifikasi akun",
          getTextAlert(context),
          getTextAlertSub(context),
          getTextAlertBtn(context)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
        Get.dialog(dialogC.dialogAlertOnly(
            IconlyLight.danger,
            "Kata Sandi terlalu lemah!",
            "Gunakan kombinasi kata sandi yang kuat",
            getTextAlert(context),
            getTextAlertSub(context)));
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
        Get.dialog(dialogC.dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Email sudah terpakai pada akun lain!", getTextAlert(context)));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Get.dialog(dialogC.dialogAlertOnly(
          IconlyLight.danger,
          "Terjadi Kesalahan.",
          "Tidak dapat mendaftarkan akun ini.",
          getTextAlert(context),
          getTextAlertSub(context)));
    }
  }

  //logout
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
