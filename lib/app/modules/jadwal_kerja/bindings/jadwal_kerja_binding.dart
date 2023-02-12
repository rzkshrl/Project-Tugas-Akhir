import 'package:get/get.dart';

import '../controllers/jadwal_kerja_controller.dart';

class JadwalKerjaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalKerjaController>(
      () => JadwalKerjaController(),
    );
  }
}
