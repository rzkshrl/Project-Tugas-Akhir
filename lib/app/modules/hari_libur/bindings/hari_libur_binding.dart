import 'package:get/get.dart';

import '../controllers/hari_libur_controller.dart';

class HariLiburBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HariLiburController>(
      () => HariLiburController(),
    );
  }
}
