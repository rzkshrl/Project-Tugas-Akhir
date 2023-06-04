// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/devicemodel.dart';
import '../../../data/models/usermodel.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  final authC = Get.put(AuthController());
  changePage(int i) {
    currentIndex.value = i;
  }

  var deviceData = DeviceModel().obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel? _user;
  String? get roles => _user?.role;

  void fetchData() async {
    UserModel user = await authC.readUser();
    String? roles = user.role;
    if (kDebugMode) {
      print("ROLES di onInit: $roles");
    }
  }

  @override
  void onInit() async {
    super.onInit();
    fetchData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
