import 'package:get/get.dart';

import '../controllers/data_pegawai_controller.dart';

class DataPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataPegawaiController>(
      () => DataPegawaiController(),
    );
  }
}
