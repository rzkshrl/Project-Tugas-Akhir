// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorpresensi/app/theme/textstyle.dart';
import 'package:monitorpresensi/app/utils/loading.dart';

import '../data/models/usermodel.dart';
import '../routes/app_pages.dart';
import '../utils/dialogDefault.dart';
import '../utils/session.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  var isAuth = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.userChanges();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final sessionController = Get.put(SessionController());

  var userData = UserModel().obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDataUsers() async* {
    var email = auth.currentUser!.email;
    yield* firestore.collection("Users").doc(email).snapshots();
  }

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
  }

  Future<bool> autoLogin() async {
    //auto login
    try {
      final isSignIn = auth.currentUser;
      if (isSignIn != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> readUser() async {
    CollectionReference users = firestore.collection("Users");

    String emailUser = auth.currentUser!.email.toString();

    final checkuser = await users.doc(emailUser).get();

    final checkUserData = checkuser.data() as Map<String, dynamic>;

    // userData(UserModel.fromJson(checkUserData));

    if (kDebugMode) {
      print("User Data : $checkUserData");
    }

    final expirationTime = DateTime.now().add(const Duration(minutes: 10));

    userData.value = (UserModel(
        uid: auth.currentUser!.uid,
        name: checkUserData['name'],
        bidang: checkUserData['bidang'],
        email: auth.currentUser!.email,
        photoUrl: checkUserData['profile'],
        role: checkUserData['role'],
        pin: checkUserData['pin'],
        creationTime:
            auth.currentUser!.metadata.creationTime!.toIso8601String(),
        lastSignInTime:
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String(),
        status: checkUserData['status']));

    if (kIsWeb) {
      StorageService.saveUserDataWithExpiration(userData.value, expirationTime);
    }

    return userData.value;
  }

  //lupa sandi
  void lupaSandi(String email, BuildContext context) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      Get.dialog(dialogAlertBtnAnimation(() {
        Get.back();
      },
          'assets/lootie/finish.json',
          111.29,
          "OK",
          "Email sukses terkirim!",
          "Cek inbox email Anda untuk reset sandi",
          getTextAlert(context),
          getTextAlertSub(context),
          getTextAlertBtn(context)));
    } catch (e) {
      Get.dialog(dialogAlertOnlyAnimation(
          'assets/lootie/warning.json',
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

      if (kIsWeb) {
        sessionController.login(myUser.user!.email!);
      }

      if (myUser.user!.emailVerified) {
        isAuth.value = true;
        readUser();
        if (kIsWeb) {
          Get.dialog(
            dialogAlertOnlySingleMsgAnimation('assets/lootie/loading.json',
                'Memuat...', getTextAlert(Get.context!)),
            barrierDismissible: false,
          );
        } else {
          Get.dialog(
            dialogAlertOnlySingleMsgAnimationMobile(
                'assets/lootie/loading.json',
                'Memuat...',
                getTextAlert(Get.context!)),
            barrierDismissible: false,
          );
        }

        await simulateDelay();
        Get.back();

        await Get.offAllNamed(Routes.HOME);
      } else {
        if (kIsWeb) {
          Get.dialog(dialogAlertBtnAnimation(() async {
            myUser.user!.sendEmailVerification();
            Get.back();
            await Get.dialog(dialogAlertBtnAnimation(() {
              Get.back();
            },
                'assets/lootie/finish.json',
                111.29,
                "OK",
                "Email sukses terkirim!",
                "Cek inbox email Anda",
                getTextAlertBtn(context),
                getTextAlertSub(context),
                getTextAlertBtn(context)));
          },
              'assets/lootie/warning.json',
              111.29,
              "Kirim",
              "Email Belum Diverifikasi!",
              "klik tombol Kirim untuk mengirim email verifikasi",
              getTextAlert(context),
              getTextAlertSub(context),
              getTextAlertBtn(context)));
        } else {
          Get.dialog(dialogAlertBtnAnimation(() async {
            myUser.user!.sendEmailVerification();
            Get.back();
            await Get.dialog(dialogAlertBtnAnimation(() {
              Get.back();
            },
                'assets/lootie/finish.json',
                111.29,
                "OK",
                "Email sukses terkirim!",
                "Cek inbox email Anda",
                getTextAlertBtnMobile(context),
                getTextAlertSubMobile(context),
                getTextAlertBtnMobile(context)));
          },
              'assets/lootie/warning.json',
              111.29,
              "Kirim",
              "Email Belum Diverifikasi!",
              "klik tombol Kirim untuk mengirim email verifikasi",
              getTextAlertMobile(context),
              getTextAlertSubMobile(context),
              getTextAlertBtnMobile(context)));
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        if (kIsWeb) {
          Get.dialog(dialogAlertOnlySingleMsgAnimation(
              'assets/lootie/warning.json',
              "Akun tidak ditemukan!",
              getTextAlert(context)));
        } else {
          Get.dialog(dialogAlertOnlySingleMsgAnimation(
              'assets/lootie/warning.json',
              "Akun tidak ditemukan!",
              getTextAlertMobile(context)));
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        if (kIsWeb) {
          Get.dialog(dialogAlertOnlySingleMsgAnimation(
              'assets/lootie/warning.json',
              "Kata sandi yang dimasukkan salah!",
              getTextAlert(context)));
        } else {
          Get.dialog(dialogAlertOnlySingleMsgAnimation(
              'assets/lootie/warning.json',
              "Kata sandi yang dimasukkan salah!",
              getTextAlertMobile(context)));
        }
      } else if (e.code == 'invalid-email') {
        if (kDebugMode) {
          print('Email address is not valid.');
        }
        if (kIsWeb) {
          Get.dialog(dialogAlertOnlyAnimation(
              'assets/lootie/warning.json',
              "Terjadi Kesalahan.",
              "Email salah. Periksa kembali email anda.",
              getTextAlert(context),
              getTextAlertSub(context)));
        } else {
          Get.dialog(dialogAlertOnlyAnimation(
              'assets/lootie/warning.json',
              "Terjadi Kesalahan.",
              "Email valid. Periksa kembali email anda.",
              getTextAlertMobile(context),
              getTextAlertSubMobile(context)));
        }
      } else {
        if (kIsWeb) {
          Get.dialog(dialogAlertOnlyAnimation(
              'assets/lootie/warning.json',
              "Terjadi Kesalahan.",
              "Periksa isian form anda.",
              getTextAlert(context),
              getTextAlertSub(context)));
        } else {
          Get.dialog(dialogAlertOnlyAnimation(
              'assets/lootie/warning.json',
              "Terjadi Kesalahan.",
              "Periksa isian form anda.",
              getTextAlertMobile(context),
              getTextAlertSubMobile(context)));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (kIsWeb) {
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "Tidak dapat masuk.",
            getTextAlert(context),
            getTextAlertSub(context)));
      } else {
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "Tidak dapat masuk.",
            getTextAlertMobile(context),
            getTextAlertSubMobile(context)));
      }
    }
  }

  //logout
  void logout() async {
    await auth.signOut();
    if (kIsWeb) {
      sessionController.logout();
      StorageService.removeCurrentRoute();
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.LOGIN_MOBILE);
    }
  }
}
