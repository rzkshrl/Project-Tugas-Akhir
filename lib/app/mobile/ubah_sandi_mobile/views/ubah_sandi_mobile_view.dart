import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ubah_sandi_mobile_controller.dart';

class UbahSandiMobileView extends GetView<UbahSandiMobileController> {
  const UbahSandiMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UbahSandiMobileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UbahSandiMobileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
