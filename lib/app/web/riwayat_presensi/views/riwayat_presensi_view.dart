import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:monitorpresensi/app/controller/api_controller.dart';
import 'package:monitorpresensi/app/data/models/firestorescanlogmodel.dart';
import 'package:monitorpresensi/app/theme/textstyle.dart';
import 'package:monitorpresensi/app/theme/theme.dart';
import 'package:monitorpresensi/app/utils/btnDefault.dart';
import 'package:responsive_framework/responsive_grid.dart';
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
    return FutureBuilder(
        future: simulateDelay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan LoadingWidget selama delay
            return const LoadingView();
          }
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
                padding: EdgeInsets.only(
                    left: 4.w, top: 2.h, right: 4.w, bottom: 8.h),
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
                          btnDefaultIcon1(
                              15.w,
                              Blue1,
                              IconlyLight.swap,
                              Yellow1,
                              "Refresh Data",
                              getTextBtnAction(context), () {
                            apiC.getAllPresenceData(context);
                          }),
                          SizedBox(
                            width: 2.5.w,
                          ),
                          btnDefaultIcon1(
                              15.w,
                              Blue1,
                              IconlyLight.swap,
                              Yellow1,
                              "Refresh Mesin",
                              getTextBtnAction(context), () {
                            apiC.getDeviceInfo(context);
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      height: 70.h,
                      child: FutureBuilder<List<KepegawaianModel>>(
                          future: controller.firestoreKepegawaianList,
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return const LoadingView();
                            }
                            final kepegawaianList =
                                // ignore: unnecessary_cast
                                snap.data! as List<KepegawaianModel>;

                            if (kepegawaianList.isEmpty) {
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset('assets/lootie/no_data.json',
                                        height: 145),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'Data kosong.',
                                      style: getTextSubHeader(context),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ResponsiveGridView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                alignment: Alignment.center,
                                gridDelegate: ResponsiveGridDelegate(
                                    crossAxisExtent: 32.5.h,
                                    mainAxisSpacing: 2.h,
                                    crossAxisSpacing: 2.w,
                                    childAspectRatio: 1.5),
                                itemCount: kepegawaianList.length,
                                itemBuilder: (context, index) {
                                  kepegawaianList
                                      .sort((a, b) => a.pin!.compareTo(b.pin!));
                                  var data = kepegawaianList[index];

                                  return itemListRiwayatPresensi(() {
                                    Get.toNamed(Routes.DETAIL_PRESENSI,
                                        arguments: data.pin!);
                                  }, data.nama!, data.pin!, data.bidang!);
                                });
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
