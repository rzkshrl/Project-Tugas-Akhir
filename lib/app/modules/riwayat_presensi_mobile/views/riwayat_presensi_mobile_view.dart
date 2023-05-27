import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_presensi_mobile_controller.dart';

class RiwayatPresensiMobileView
    extends GetView<RiwayatPresensiMobileController> {
  const RiwayatPresensiMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiwayatPresensiMobileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RiwayatPresensiMobileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
