import 'package:get/get.dart';

import '../controllers/mesin_controller.dart';

class MesinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MesinController>(
      () => MesinController(),
    );
  }
}
