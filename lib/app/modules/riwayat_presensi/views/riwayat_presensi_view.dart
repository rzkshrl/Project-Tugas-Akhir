import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';

import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiwayatPresensiView'),
        centerTitle: true,
      ),
      drawer: NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      body: Center(
        child: Text(
          'RiwayatPresensiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
