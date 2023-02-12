import 'package:get/get.dart';

import '../controllers/jam_kerja_controller.dart';

class JamKerjaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JamKerjaController>(
      () => JamKerjaController(),
    );
  }
}
