import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../controllers/navigation_drawer_controller.dart';

class NavigationDrawerView extends GetView<NavigationDrawerController> {
  const NavigationDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationDrawerController());

    if (kIsWeb) {
      return Drawer(
        width: 350,
        backgroundColor: Blue1,
        shadowColor: Colors.transparent,
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 43,
            ),
            Text(
              "Menu",
              style: getTextMenu(context),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildDrawerItemSingle(
                      text: Text(
                        "Beranda/Riwayat Presensi",
                        style: getTextItemMenu(context),
                      ),
                      padding: const EdgeInsets.only(left: 16),
                      icon: IconlyLight.document,
                      iconColor: Yellow1,
                      visualDensity: const VisualDensity(vertical: 3),
                      iconSize: 26,
                      tileColor: Get.currentRoute == Routes.RIWAYAT_PRESENSI
                          ? Blue2
                          : null,
                      onTap: () => navigate(0)),
                  Obx(
                    () => ExpansionTile(
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: AnimatedRotation(
                          turns: controller.isExpanded.value ||
                                  Get.currentRoute ==
                                      Routes.REKAP_PRESENSI_ALL ||
                                  Get.currentRoute ==
                                      Routes.REKAP_PRESENSI_PER ||
                                  Get.currentRoute == Routes.REKAP_SCANLOG_PER
                              ? .5
                              : 0,
                          duration: const Duration(milliseconds: 500),
                          child: FaIcon(
                            FontAwesomeIcons.chevronDown,
                            color: controller.isExpanded.value ||
                                    Get.currentRoute ==
                                        Routes.REKAP_PRESENSI_ALL ||
                                    Get.currentRoute ==
                                        Routes.REKAP_PRESENSI_PER ||
                                    Get.currentRoute == Routes.REKAP_SCANLOG_PER
                                ? Yellow1
                                : Yellow1.withOpacity(0.4),
                            size: 15,
                          ),
                        ),
                      ),
                      onExpansionChanged: (value) {
                        controller.expand(value);
                      },
                      initiallyExpanded: Get.currentRoute ==
                                  Routes.REKAP_PRESENSI_ALL ||
                              Get.currentRoute == Routes.REKAP_PRESENSI_PER ||
                              Get.currentRoute == Routes.REKAP_SCANLOG_PER
                          ? true
                          : false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 4.5),
                        child: Text(
                          "Rekapitulasi",
                          style: getTextItemMenu(context),
                        ),
                      ),
                      leading: SizedBox(
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          child: Icon(
                            IconlyLight.paper_download,
                            color: Yellow1,
                            size: 26,
                          ),
                        ),
                      ),
                      backgroundColor: Blue2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      collapsedBackgroundColor: Get.currentRoute ==
                                  Routes.REKAP_PRESENSI_ALL ||
                              Get.currentRoute == Routes.REKAP_PRESENSI_PER ||
                              Get.currentRoute == Routes.REKAP_SCANLOG_PER
                          ? Blue2
                          : Blue1,
                      childrenPadding: const EdgeInsets.only(left: 57.5),
                      children: [
                        buildDrawerItemSubMenu(
                            text: Text(
                              "Rekap Presensi Semua Pegawai",
                              style:
                                  Get.currentRoute == Routes.REKAP_PRESENSI_ALL
                                      ? getTextItemSubMenu(context)
                                      : getTextItemSubMenuDisabled(context),
                            ),
                            visualDensity: const VisualDensity(vertical: -2),
                            onTap: () => navigate(1)),
                        buildDrawerItemSubMenu(
                            text: Text(
                              "Rekap Presensi Per Pegawai",
                              style:
                                  Get.currentRoute == Routes.REKAP_PRESENSI_PER
                                      ? getTextItemSubMenu(context)
                                      : getTextItemSubMenuDisabled(context),
                            ),
                            visualDensity: const VisualDensity(vertical: -2),
                            onTap: () => navigate(2)),
                        buildDrawerItemSubMenu(
                            text: Text(
                              "Rekap Scanlog Per Pegawai",
                              style:
                                  Get.currentRoute == Routes.REKAP_SCANLOG_PER
                                      ? getTextItemSubMenu(context)
                                      : getTextItemSubMenuDisabled(context),
                            ),
                            visualDensity: const VisualDensity(vertical: -2),
                            onTap: () => navigate(3)),
                      ],
                    ),
                  ),
                  buildDrawerItemSingle(
                      text: Text(
                        "Data Kepegawaian",
                        style: getTextItemMenu(context),
                      ),
                      padding: const EdgeInsets.only(left: 16),
                      icon: IconlyLight.user_1,
                      iconColor: Yellow1,
                      visualDensity: const VisualDensity(vertical: 3),
                      iconSize: 26,
                      tileColor: Get.currentRoute == Routes.DATA_PEGAWAI
                          ? Blue2
                          : null,
                      onTap: () => navigate(4)),
                  Obx(
                    () => ExpansionTile(
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: AnimatedRotation(
                          turns: controller.isExpanded1.value ||
                                  Get.currentRoute == Routes.JAM_KERJA ||
                                  Get.currentRoute == Routes.KET_IZIN ||
                                  Get.currentRoute == Routes.HARI_LIBUR
                              ? .5
                              : 0,
                          duration: const Duration(milliseconds: 500),
                          child: FaIcon(
                            FontAwesomeIcons.chevronDown,
                            color: controller.isExpanded1.value ||
                                    Get.currentRoute == Routes.JAM_KERJA ||
                                    Get.currentRoute == Routes.KET_IZIN ||
                                    Get.currentRoute == Routes.HARI_LIBUR
                                ? Yellow1
                                : Yellow1.withOpacity(0.4),
                            size: 15,
                          ),
                        ),
                      ),
                      onExpansionChanged: (value) {
                        controller.expand1(value);
                      },
                      initiallyExpanded: Get.currentRoute == Routes.JAM_KERJA ||
                              Get.currentRoute == Routes.KET_IZIN ||
                              Get.currentRoute == Routes.HARI_LIBUR
                          ? true
                          : false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 4.5),
                        child: Text(
                          "Pengaturan",
                          style: getTextItemMenu(context),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      leading: SizedBox(
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Icon(
                            IconlyLight.setting,
                            color: Yellow1,
                            size: 26,
                          ),
                        ),
                      ),
                      backgroundColor: Blue2,
                      collapsedBackgroundColor:
                          Get.currentRoute == Routes.JAM_KERJA ||
                                  Get.currentRoute == Routes.KET_IZIN ||
                                  Get.currentRoute == Routes.HARI_LIBUR
                              ? Blue2
                              : Blue1,
                      childrenPadding: const EdgeInsets.only(left: 56.5),
                      children: [
                        buildDrawerItemSubMenu(
                            text: Text(
                              "Jam Kerja",
                              style: Get.currentRoute == Routes.JAM_KERJA
                                  ? getTextItemSubMenu(context)
                                  : getTextItemSubMenuDisabled(context),
                            ),
                            visualDensity: const VisualDensity(vertical: -2),
                            onTap: () => navigate(5)),
                        buildDrawerItemSubMenu(
                            text: Text(
                              "Hari Libur/Cuti Bersama",
                              style: Get.currentRoute == Routes.HARI_LIBUR
                                  ? getTextItemSubMenu(context)
                                  : getTextItemSubMenuDisabled(context),
                            ),
                            visualDensity: const VisualDensity(vertical: -2),
                            onTap: () => navigate(6)),
                        buildDrawerItemSubMenu(
                            text: Text(
                              "Pengecualian",
                              style: Get.currentRoute == Routes.PENGECUALIAN
                                  ? getTextItemSubMenu(context)
                                  : getTextItemSubMenuDisabled(context),
                            ),
                            visualDensity: const VisualDensity(vertical: -2),
                            onTap: () => navigate(7)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      );
    } else {
      // WELCOME SCREEN MOBILE
      return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'HALO Ini MOBILE',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }

  Widget buildDrawerItemSingle(
      {required Text text,
      required IconData icon,
      required double iconSize,
      required EdgeInsets padding,
      required VisualDensity visualDensity,
      required Color? iconColor,
      required Color? tileColor,
      required VoidCallback onTap}) {
    return ListTile(
      leading: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: padding,
          child: Icon(icon, color: iconColor, size: iconSize),
        ),
      ),
      title: text,
      minLeadingWidth: 0,
      visualDensity: visualDensity,
      tileColor: tileColor,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget buildDrawerItemSubMenu({
    required Text text,
    required VoidCallback onTap,
    required VisualDensity visualDensity,
  }) {
    return ListTile(
      title: text,
      minLeadingWidth: 0,
      visualDensity: visualDensity,
      onTap: onTap,
    );
  }

  navigate(int index) {
    if (index == 0) {
      Get.offAllNamed(Routes.RIWAYAT_PRESENSI);
    } else if (index == 1) {
      Get.offAllNamed(Routes.REKAP_PRESENSI_ALL);
    } else if (index == 2) {
      Get.offAllNamed(Routes.REKAP_PRESENSI_PER);
    } else if (index == 3) {
      Get.offAllNamed(Routes.REKAP_SCANLOG_PER);
    } else if (index == 4) {
      Get.offAllNamed(Routes.DATA_PEGAWAI);
    } else if (index == 5) {
      Get.offAllNamed(Routes.JAM_KERJA);
    } else if (index == 6) {
      Get.offAllNamed(Routes.HARI_LIBUR);
    } else if (index == 7) {
      Get.offAllNamed(Routes.PENGECUALIAN);
    }
  }
}
