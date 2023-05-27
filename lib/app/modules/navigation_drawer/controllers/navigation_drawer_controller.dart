// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

class NavigationDrawerController extends GetxController {
  final count = 0.obs;

  var isExpanded = false.obs;

  expand(value) {
    isExpanded.value = value;
  }

  var isExpanded1 = false.obs;

  expand1(value1) {
    isExpanded1.value = value1;
  }

  @override
  void onInit() {
    super.onInit();
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
