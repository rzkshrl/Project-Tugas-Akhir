import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lupa_sandi_mobile_controller.dart';

class LupaSandiMobileView extends GetView<LupaSandiMobileController> {
  const LupaSandiMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LupaSandiMobileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LupaSandiMobileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
