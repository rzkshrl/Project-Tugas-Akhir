import 'package:get/get.dart';

import '../controllers/riwayat_presensi_mobile_controller.dart';

class RiwayatPresensiMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatPresensiMobileController>(
      () => RiwayatPresensiMobileController(),
    );
  }
}
