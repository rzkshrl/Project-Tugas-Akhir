import 'package:get/get.dart';

import '../controllers/ubah_profil_mobile_controller.dart';

class UbahProfilMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahProfilMobileController>(
      () => UbahProfilMobileController(),
    );
  }
}
