import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var currentIndex = 0.obs;
  changePage(int i) {
    currentIndex.value = i;
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
  void onClose() {}
}
