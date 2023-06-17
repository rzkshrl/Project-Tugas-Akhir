// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileMobileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userNow() async* {
    var email = auth.currentUser!.email;
    yield* firestore.collection("Users").doc(email).snapshots();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
