// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';

import '../data/models/usermodel.dart';
import '../routes/app_pages.dart';
import '../utils/dialogDefault.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  var isAuth = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.userChanges();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  //store user data
  void syncUsers(String? password) async {
    CollectionReference users = firestore.collection("Users");

    String emailUser = auth.currentUser!.email.toString();

    final checkuser = await users.doc(emailUser).get();

    final checkUserData = checkuser.data() as Map<String, dynamic>;

    // userData(UserModel.fromJson(checkUserData));

    if (kDebugMode) {
      print("User Data : $checkUserData");
    }

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
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String()));

    userData.refresh();

    if (checkuser.data() == null) {
      users.doc(emailUser).set({
        'uid': auth.currentUser!.uid,
        'name': auth.currentUser!.displayName,
        'email': auth.currentUser!.email,
        'role': "user",
        'bidang': 'Pegawai',
        'profile': '',
        'lastSignInDate':
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String(),
        'creationTime':
            auth.currentUser!.metadata.creationTime!.toIso8601String(),
      });
    } else {
      // return null;
      users.doc(emailUser).update({
        'lastSignInDate':
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String(),
      });
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
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String()));

    return userData.value;
  }

  //lupa sandi
  void lupaSandi(String email, BuildContext context) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      Get.dialog(dialogAlertBtn(() {
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
      Get.dialog(dialogAlertOnly(
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
        syncUsers(password);
        isAuth.value = true;
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

        await Future.delayed(
          const Duration(seconds: 5),
        );
        Get.back();

        await Get.offAllNamed(Routes.HOME);
        // }
        // });
      } else {
        if (kIsWeb) {
          Get.dialog(dialogAlertBtn(() async {
            myUser.user!.sendEmailVerification();
            Get.back();
            await Get.dialog(dialogAlertBtn(() {
              Get.back();
            },
                IconlyLight.tick_square,
                111.29,
                "OK",
                "Email sukses terkirim!",
                "Cek inbox email Anda",
                getTextAlertBtn(context),
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
        } else {
          Get.dialog(dialogAlertBtn(() async {
            myUser.user!.sendEmailVerification();
            Get.back();
            await Get.dialog(dialogAlertBtn(() {
              Get.back();
            },
                IconlyLight.tick_square,
                111.29,
                "OK",
                "Email sukses terkirim!",
                "Cek inbox email Anda",
                getTextAlertBtnMobile(context),
                getTextAlertSubMobile(context),
                getTextAlertBtnMobile(context)));
          },
              IconlyLight.danger,
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
          Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
              "Akun tidak ditemukan!", getTextAlert(context)));
        } else {
          Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
              "Akun tidak ditemukan!", getTextAlertMobile(context)));
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        if (kIsWeb) {
          Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
              "Kata sandi yang dimasukkan salah!", getTextAlert(context)));
        } else {
          Get.dialog(dialogAlertOnlySingleMsg(
              IconlyLight.danger,
              "Kata sandi yang dimasukkan salah!",
              getTextAlertMobile(context)));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (kIsWeb) {
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Terjadi Kesalahan.",
            "Tidak dapat masuk.",
            getTextAlert(context),
            getTextAlertSub(context)));
      } else {
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Terjadi Kesalahan.",
            "Tidak dapat masuk.",
            getTextAlertMobile(context),
            getTextAlertSubMobile(context)));
      }
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

      syncUsers(password);
      await myUser.user!.sendEmailVerification();
      Get.dialog(dialogAlertBtn(() {
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
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Kata Sandi terlalu lemah!",
            "Gunakan kombinasi kata sandi yang kuat",
            getTextAlert(context),
            getTextAlertSub(context)));
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Email sudah terpakai pada akun lain!", getTextAlert(context)));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Get.dialog(dialogAlertOnly(
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
    if (kIsWeb) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.LOGIN_MOBILE);
    }
  }
}
