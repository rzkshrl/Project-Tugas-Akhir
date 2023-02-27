import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/controller/api_controller.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/reqresapimodel.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final apiC = Get.put(APIController());
    return Scaffold(
        backgroundColor: light,
        drawer: const NavigationDrawerView(),
        drawerScrimColor: light.withOpacity(0.6),
        appBar: AppBar(
          title: null,
          backgroundColor: light,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                icon: FaIcon(
                  FontAwesomeIcons.bars,
                  color: dark,
                ));
          }),
          actions: [
            IconButton(
                onPressed: () => authC.logout(),
                icon: Icon(
                  IconlyLight.logout,
                  color: dark,
                )),
          ],
        ),
        body: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${authC.userModel.value.uid}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${authC.userModel.value.email}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${authC.userModel.value.role}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
