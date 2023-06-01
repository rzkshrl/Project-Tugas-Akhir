import 'package:get/get.dart';

import '../controllers/login_mobile_controller.dart';

class LoginMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginMobileController>(
      () => LoginMobileController(),
    );
  }
}
