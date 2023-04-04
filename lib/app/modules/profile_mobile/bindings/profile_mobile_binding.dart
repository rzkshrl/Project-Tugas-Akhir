import 'package:get/get.dart';

import '../controllers/profile_mobile_controller.dart';

class ProfileMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileMobileController>(
      () => ProfileMobileController(),
    );
  }
}
