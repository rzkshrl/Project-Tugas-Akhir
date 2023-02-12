import 'package:get/get.dart';

import '../controllers/rekap_scanlog_per_controller.dart';

class RekapScanlogPerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapScanlogPerController>(
      () => RekapScanlogPerController(),
    );
  }
}
