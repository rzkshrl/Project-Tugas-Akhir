import 'package:get/get.dart';

import '../controllers/ket_izin_controller.dart';

class KetIzinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KetIzinController>(
      () => KetIzinController(),
    );
  }
}
