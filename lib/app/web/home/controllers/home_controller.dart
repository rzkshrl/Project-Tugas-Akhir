// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/devicemodel.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  changePage(int i) {
    currentIndex.value = i;
  }

  var deviceData = DeviceModel().obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
