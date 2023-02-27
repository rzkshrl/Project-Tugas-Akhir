import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../controller/api_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../data/models/reqresapimodel.dart';
import '../../../theme/theme.dart';
import '../../../utils/loading.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/rekap_presensi_all_controller.dart';

import 'package:http/http.dart' as http;

class RekapPresensiAllView extends GetView<RekapPresensiAllController> {
  const RekapPresensiAllView({Key? key}) : super(key: key);
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
      body: Builder(
          // future: apiC.getDataSDK(),
          builder: (context) {
        // if (snap.connectionState == ConnectionState.waiting) {
        //   return LoadingView();
        // }
        // if (snap.hasData) {
        Uri url = Uri.parse("https:192.168.0.206:8008/user/all/paging");
        var response = http.get(url);

        log("{$response}");
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rekap Presensi Semua Pegawai',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        );
        // } else {
        //   return Center(
        //     child: Text(
        //       'NO DATA',
        //       style: TextStyle(fontSize: 20),
        //     ),
        //   );
        // }
      }),
    );
  }
}
