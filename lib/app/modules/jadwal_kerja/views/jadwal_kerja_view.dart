import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/dialogTextField.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/textfield.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/jadwal_kerja_controller.dart';

class JadwalKerjaView extends GetView<JadwalKerjaController> {
  const JadwalKerjaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final c = Get.put(JadwalKerjaController());
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jadwal Kerja',
                    style: getTextHeader2(context),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    btnDefaultIcon1(13.w, Blue1, IconlyLight.plus, Yellow1,
                        "Tambah Data", getTextBtnAction(context), () {
                      Get.dialog(dialogTextJadwalKerja(
                          context,
                          btnDefaultIcon1(10.w, Blue4, IconlyLight.tick_square,
                              Yellow1, "Kirim", getTextBtnAction(context), () {
                            if (kDebugMode) {
                              print(c.selectedDays);
                            }

                            if (textC.namaJadwalKerjaKey.value.currentState!.validate() &&
                                textC.kodeJadwalKerjaKey.value.currentState!
                                    .validate() &&
                                textC.ketJadwalKerjaKey.value.currentState!
                                    .validate()) {
                              c.addJadker(
                                  textC.namaJadwalKerjaC.text,
                                  textC.kodeJadwalKerjaC.text,
                                  textC.ketJadwalKerjaC.text);
                            }
                          })));
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
                child: const SingleChildScrollView(
                    // child: PaginatedDataTable2(
                    //   columns: [
                    //     DataColumn(label: Text("PIN")),
                    //     DataColumn(label: Text('Scan Date'))
                    //   ],
                    //   source: dataScanlog,
                    //   rowsPerPage: controller.rowPerPage.value,
                    //   onRowsPerPageChanged: (index) {
                    //     controller.rowPerPage.value = index!;
                    //   },
                    // ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
