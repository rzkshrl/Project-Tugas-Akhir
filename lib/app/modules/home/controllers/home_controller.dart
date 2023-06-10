// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/session.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  final authC = Get.put(AuthController());
  changePage(int i) {
    currentIndex.value = i;
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
