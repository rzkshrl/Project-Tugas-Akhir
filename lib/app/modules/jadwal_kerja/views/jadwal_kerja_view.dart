import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/theme.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/jadwal_kerja_controller.dart';

class JadwalKerjaView extends GetView<JadwalKerjaController> {
  const JadwalKerjaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JadwalKerjaView'),
        centerTitle: true,
      ),
      drawer: NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      body: Center(
        child: Text(
          'JadwalKerjaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
