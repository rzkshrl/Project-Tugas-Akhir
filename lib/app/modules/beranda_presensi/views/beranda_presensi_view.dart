import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/modules/data_pegawai/views/data_pegawai_view.dart';
import 'package:project_tugas_akhir/app/modules/jadwal_kerja/views/jadwal_kerja_view.dart';
import 'package:project_tugas_akhir/app/modules/jam_kerja/views/jam_kerja_view.dart';
import 'package:project_tugas_akhir/app/modules/rekap_presensi_all/views/rekap_presensi_all_view.dart';
import 'package:project_tugas_akhir/app/modules/rekap_presensi_per/views/rekap_presensi_per_view.dart';
import 'package:project_tugas_akhir/app/modules/rekap_scanlog_per/views/rekap_scanlog_per_view.dart';
import 'package:project_tugas_akhir/app/modules/riwayat_presensi/views/riwayat_presensi_view.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';

import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../controllers/beranda_presensi_controller.dart';

class BerandaPresensiView extends GetView<BerandaPresensiController> {
  const BerandaPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 1200;
    if (kIsWeb) {
      return Scaffold();
    } else {
      // WELCOME SCREEN MOBILE
      return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'HALO Ini MOBILE',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
}
