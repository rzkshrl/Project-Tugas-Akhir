import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/controller/api_controller.dart';
import 'package:project_tugas_akhir/app/data/models/firestorescanlogmodel.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:project_tugas_akhir/app/utils/btnDefault.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/loading.dart';
import '../../../utils/session.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final controller = Get.put(RiwayatPresensiController());
    final apiC = Get.put(APIController(context1: context));
    StorageService.saveCurrentRoute(Routes.RIWAYAT_PRESENSI);
    return Scaffold(
      backgroundColor: light,
      drawer: const NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: light,
          automaticallyImplyLeading: false,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: null,
          title: Padding(
            padding: EdgeInsets.only(
              left: 1.5.w,
              top: 26,
            ),
            child: Builder(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                      icon: FaIcon(
                        FontAwesomeIcons.bars,
                        color: Blue1,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 1.5.w,
                    ),
                    child: IconButton(
                      color: Blue1,
                      onPressed: () => authC.logout(),
                      icon: const Icon(IconlyLight.logout),
                      iconSize: 30,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w, bottom: 8.h),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Riwayat Presensi Semua Pegawai',
                    style: getTextHeader(context),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '',
                        style: getTextSubHeader(context),
                      ),
                      Text(
                        '',
                        style: getTextSubHeader(context),
                      ),
                      Text(
                        '',
                        style: getTextSubHeader(context),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    btnDefaultIcon1(13.w, Blue1, IconlyLight.swap, Yellow1,
                        "Refresh Data", getTextBtnAction(context), () {
                      apiC.getAllPresenceData(context);
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                decoration: BoxDecoration(color: Blue1.withOpacity(0.2)),
                width: 90.w,
                height: 70.h,
                child: StreamBuilder<List<KepegawaianModel>>(
                    stream: controller.firestoreKepegawaianList,
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return const LoadingView();
                      }
                      final kepegawaianList =
                          // ignore: unnecessary_cast
                          snap.data! as List<KepegawaianModel>;
                      return ListView.builder(
                          itemCount: kepegawaianList.length,
                          itemBuilder: (context, index) {
                            var data = kepegawaianList[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_PRESENSI,
                                    arguments: data.pin!);
                              },
                              child: ListTile(
                                title: Text(data.nama!),
                                titleTextStyle: getTextTableData(context),
                                subtitle: Text(data.pin!),
                                subtitleTextStyle: getTextTableData(context),
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
