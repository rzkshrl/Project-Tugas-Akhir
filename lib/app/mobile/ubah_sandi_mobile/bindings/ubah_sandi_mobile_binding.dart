import 'package:get/get.dart';

import '../controllers/ubah_sandi_mobile_controller.dart';

class UbahSandiMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahSandiMobileController>(
      () => UbahSandiMobileController(),
    );
  }
}
