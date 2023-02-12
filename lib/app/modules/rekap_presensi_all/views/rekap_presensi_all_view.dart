import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rekap_presensi_all_controller.dart';

class RekapPresensiAllView extends GetView<RekapPresensiAllController> {
  const RekapPresensiAllView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RekapPresensiAllView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RekapPresensiAllView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
