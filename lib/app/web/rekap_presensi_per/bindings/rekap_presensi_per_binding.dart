import 'package:get/get.dart';

import '../controllers/rekap_presensi_per_controller.dart';

class RekapPresensiPerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapPresensiPerController>(
      () => RekapPresensiPerController(),
    );
  }
}
