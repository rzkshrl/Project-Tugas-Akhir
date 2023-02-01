import 'package:get/get.dart';

import '../controllers/lupa_sandi_controller.dart';

class LupaSandiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupaSandiController>(
      () => LupaSandiController(),
    );
  }
}
