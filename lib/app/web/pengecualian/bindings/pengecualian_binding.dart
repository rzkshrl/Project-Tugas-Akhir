import 'package:get/get.dart';

import '../controllers/pengecualian_controller.dart';

class PengecualianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengecualianController>(
      () => PengecualianController(),
    );
  }
}
