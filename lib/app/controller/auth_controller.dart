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

  Stream<QuerySnapshot<Object?>> streamDataUsers() {
    CollectionReference users = firestore.collection("Users");
    return users.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getUserDoc() async {
    String emailUser = auth.currentUser!.email.toString();
    DocumentReference user = firestore.collection("Users").doc(emailUser);
    return user.get();
  }

  Future<DocumentSnapshot<Object?>> role() async {
    String emailUser = auth.currentUser!.email.toString();
    CollectionReference users = firestore.collection('Users');

    return users.doc(emailUser).get();
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
      // Dialog(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //   backgroundColor: Colors.white,
      //   child: Container(
      //     width: 193.93,
      //     height: 194.73,
      //     child: Column(
      //       children: [Icon(PhosphorIcons.xCircle)],
      //     ),
      //   ),
      // );
      return false;
    }
  }

  //store user data
  void syncUsers(String password, BuildContext context) async {
    CollectionReference users = firestore.collection("Users");

    String emailUser = auth.currentUser!.email.toString();

    final checkuser = await users.doc(emailUser).get();

    if (checkuser.data() == null) {
      users.doc(emailUser).set({
        'uid': auth.currentUser!.uid,
        'email': auth.currentUser!.email,
        'role': "user",
        'profile': '',
        'password': password,
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

    final checkUserData = checkuser.data() as Map<String, dynamic>;

    // userData(UserModel.fromJson(checkUserData));

    if (kDebugMode) {
      print("User Data : $checkUserData");
    }

    userData.value = (UserModel(
        uid: auth.currentUser!.uid,
        name: auth.currentUser!.displayName,
        email: auth.currentUser!.email,
        photoUrl: checkUserData['profile'],
        password: password,
        role: checkUserData['role'],
        creationTime:
            auth.currentUser!.metadata.creationTime!.toIso8601String(),
        lastSignInTime:
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String()));

    userData.refresh();
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
        auth.authStateChanges().listen((User? user) async {
          if (user == null) {
            if (kDebugMode) {
              print('User is currently signed out!');
            }
          } else {
            if (kDebugMode) {
              print('User is signed in!');
            }

            syncUsers(password, context);
            isAuth.value = true;
            await Future.delayed(const Duration(seconds: 5));

            await Get.offAllNamed(Routes.HOME);
          }
        });
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
        if (kDebugMode) {
          print('No user found for that email.');
        }

        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Akun tidak ditemukan!", getTextAlert(context)));
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }

        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Kata sandi yang dimasukkan salah!", getTextAlert(context)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      Get.dialog(dialogAlertOnly(
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

      syncUsers(password, context);
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
    Get.offAllNamed(Routes.LOGIN);
  }
}
