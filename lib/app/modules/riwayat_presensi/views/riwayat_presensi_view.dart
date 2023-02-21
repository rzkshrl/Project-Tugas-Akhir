import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';

import '../../../controller/auth_controller.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    return Scaffold(
      drawer: NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: FaIcon(FontAwesomeIcons.bars));
        }),
        actions: [
          IconButton(
              onPressed: () => authC.logout(), icon: Icon(IconlyLight.logout)),
        ],
      ),
      body: Center(
        child: Text(
          'RiwayatPresensiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
