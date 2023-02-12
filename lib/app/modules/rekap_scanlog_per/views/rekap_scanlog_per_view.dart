import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rekap_scanlog_per_controller.dart';

class RekapScanlogPerView extends GetView<RekapScanlogPerController> {
  const RekapScanlogPerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RekapScanlogPerView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RekapScanlogPerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
