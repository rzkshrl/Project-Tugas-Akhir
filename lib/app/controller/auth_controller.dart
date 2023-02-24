import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';

import '../data/models/usersmodel.dart';
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
    String emailUser = auth.currentUser!.email.toString();
    DocumentReference user = firestore.collection("Users").doc(emailUser);
    return user.get();
  }

  Future<DocumentSnapshot<Object?>> role(BuildContext context) async {
    String emailUser = auth.currentUser!.email.toString();
    CollectionReference users = firestore.collection('Users');

    return users.doc(emailUser).get();

    // if (userCheck.data() != null) {
    //   return userCheck;
    // } else {
    //   Get.dialog(dialogC.dialogAlertBtn(() {
    //     logout();
    //   },
    //       IconlyLight.danger,
    //       111.29,
    //       "Keluar",
    //       "Terjadi Kesalahan!",
    //       "Silakan masuk ulang.",
    //       getTextAlert(context),
    //       getTextAlertSub(context),
    //       getTextAlertBtn(context)));
    // }
  }

  //store user data
  void syncUsers(String email, String password, BuildContext context) async {
    String emailUser = auth.currentUser!.email.toString();

    CollectionReference users = firestore.collection('Users');

    final checkUserData = await users.doc(emailUser).get();
    final currentUserData = checkUserData.data();

    // try {
      if (checkUserData.data() == null) {
        users.doc(emailUser).set({
          'uid': auth.currentUser?.uid,
          'email': email,
          'profile': '',
          'password': password,
          'role': "user",
          'lastSignInDate':
              auth.currentUser?.metadata.lastSignInTime?.toIso8601String(),
          'creationTime':
              auth.currentUser?.metadata.creationTime?.toIso8601String(),
        });
      } else {
        users.doc(emailUser).update({
          'lastSignInDate':
              auth.currentUser?.metadata.lastSignInTime?.toIso8601String(),
        });
      }
    // } catch (e) {
    //   print(e);
    //   Get.dialog(dialogC.dialogAlertOnly(
    //       IconlyLight.danger,
    //       "Terjadi Kesalahan.",
    //       "Tidak dapat menambahkan data.",
    //       getTextAlert(context),
    //       getTextAlertSub(context)));
    // }
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
      Get.dialog(dialogC.dialogAlertOnly(
          IconlyLight.danger,
          "Terjadi Kesalahan.",
          "Tidak dapat reset sandi.",
          getTextAlert(context),
          getTextAlertSub(context)));
    }
  }

  //login
  void login(String email, String password, BuildContext context) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (myUser.user!.emailVerified) {
        syncUsers(email, password, context);
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.dialog(dialogC.dialogAlertBtn(() async {
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
        },
            IconlyLight.danger,
            111.29,
            "Kirim",
            "Email Belum Diverifikasi!",
            "klik tombol Kirim untuk mengirim email verifikasi",
            getTextAlert(context),
            getTextAlertSub(context),
            getTextAlertBtn(context)));
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

      syncUsers(email, password, context);
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
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
