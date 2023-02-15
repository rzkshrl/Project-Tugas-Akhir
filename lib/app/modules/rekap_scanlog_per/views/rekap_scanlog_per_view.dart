import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/theme.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
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
      drawer: NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      body: Center(
        child: Text(
          'RekapScanlogPerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
