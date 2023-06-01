import 'package:get/get.dart';

import '../controllers/lupa_sandi_mobile_controller.dart';

class LupaSandiMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupaSandiMobileController>(
      () => LupaSandiMobileController(),
    );
  }
}
