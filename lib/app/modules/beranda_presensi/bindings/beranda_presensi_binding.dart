import 'package:get/get.dart';

import '../controllers/beranda_presensi_controller.dart';

class BerandaPresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BerandaPresensiController>(
      () => BerandaPresensiController(),
    );
  }
}
