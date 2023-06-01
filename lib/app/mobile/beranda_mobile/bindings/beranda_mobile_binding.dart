import 'package:get/get.dart';

import '../controllers/beranda_mobile_controller.dart';

class BerandaMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BerandaMobileController>(
      () => BerandaMobileController(),
    );
  }
}
