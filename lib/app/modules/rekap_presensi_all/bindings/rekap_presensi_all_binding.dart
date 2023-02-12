import 'package:get/get.dart';

import '../controllers/rekap_presensi_all_controller.dart';

class RekapPresensiAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapPresensiAllController>(
      () => RekapPresensiAllController(),
    );
  }
}
