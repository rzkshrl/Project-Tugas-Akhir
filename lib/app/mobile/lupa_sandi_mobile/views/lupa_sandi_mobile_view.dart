import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/theme.dart';
import '../controllers/lupa_sandi_mobile_controller.dart';

class LupaSandiMobileView extends GetView<LupaSandiMobileController> {
  const LupaSandiMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: light, body: SingleChildScrollView());
  }
}
