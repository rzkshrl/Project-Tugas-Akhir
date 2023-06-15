// ignore_for_file: invalid_use_of_protected_member, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:project_tugas_akhir/app/utils/datePicker.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:responsive_framework/responsive_grid.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/loading.dart';
import '../../../utils/session.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/rekap_scanlog_per_controller.dart';

class RekapScanlogPerView extends GetView<RekapScanlogPerController> {
  const RekapScanlogPerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final controller = Get.put(RekapScanlogPerController());
    StorageService.saveCurrentRoute(Routes.REKAP_SCANLOG_PER);
    final dateFormatter = DateFormat('MMMM yyyy', 'id-ID');
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
            body: Obx(
              () => SingleChildScrollView(
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
                            'Rekapitulasi Scanlog Pegawai',
                            style: getTextHeader(context),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            children: [
                              Text(
                                controller.start == null
                                    ? dateFormatter.format(controller.end.value)
                                    : dateFormatter.format(controller.start!),
                                style: getTextSubHeader(context),
                              ),
                              Text(
                                ' - ',
                                style: getTextSubHeader(context),
                              ),
                              Text(
                                controller.end.value == DateTime.now()
                                    ? '--'
                                    : dateFormatter
                                        .format(controller.end.value),
                                style: getTextSubHeader(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 1.8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            dropdownNormalField2(
                                context,
                                18.w,
                                cDropdown.pinRekapKey.value,
                                (value) {
                                  if (value != null) {
                                    cDropdown.pinRekapC.text = value;
                                  }
                                },
                                controller.pinList.value,
                                (item) {
                                  int index = controller.pinList.indexOf(item);
                                  return controller.namaList[index];
                                },
                                null,
                                'Pilih Pegawai...',
                                Colors.transparent,
                                dark,
                                Blue1,
                                cDropdown.pinRekapC.text == ''
                                    ? null
                                    : cDropdown.pinRekapC.text),
                            SizedBox(
                              width: 1.5.w,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 3.h,
                                ),
                                textformDatePicker(
                                    controller.end.value
                                            .isAtSameMomentAs(DateTime.now())
                                        ? TextEditingController(text: '')
                                        : textC.datepickerC, () {
                                  Get.dialog(datePickerDialog(
                                      DateRangePickerSelectionMode.range,
                                      (value) {
                                    if (value != null) {
                                      if ((value as PickerDateRange).endDate !=
                                          null) {
                                        controller.pickRangeDate(
                                            value.startDate!, value.endDate!);
                                        Get.back();
                                      } else {
                                        Get.dialog(dialogAlertOnlyAnimation(
                                            'assets/lootie/warning.json',
                                            "Terjadi Kesalahan.",
                                            "Pilih tanggal jangkauan\n(Senin-Sabtu, dsb)\n(tekan tanggal dua kali \nuntuk memilih tanggal yang sama)",
                                            getTextAlert(context),
                                            getTextAlertSub(context)));
                                      }
                                    } else {
                                      Get.dialog(dialogAlertOnlyAnimation(
                                          'assets/lootie/warning.json',
                                          "Terjadi Kesalahan.",
                                          "Tanggal tidak dipilih.",
                                          getTextAlert(context),
                                          getTextAlertSub(context)));
                                    }
                                  }, null, null));
                                }, 24.w, light, Blue1, dark, Blue1,
                                    getTextLogin(Get.context!), null),
                              ],
                            ),
                            SizedBox(
                              width: 1.5.w,
                            ),
                            Column(
                              children: [
                                btnDefaultIcon1(
                                    13.w,
                                    Blue1,
                                    IconlyLight.document,
                                    Yellow1,
                                    "Preview Rekap",
                                    getTextBtnAction(context), () {
                                  if (textC.datepickerKey.value.currentState!
                                          .validate() &&
                                      cDropdown.pinRekapKey.value.currentState!
                                          .validate()) {
                                    controller
                                        .previewPDF(cDropdown.pinRekapC.text);
                                  }
                                }),
                                SizedBox(
                                  height: 1.h,
                                ),
                                btnDefaultIcon1(
                                    13.w,
                                    Blue1,
                                    IconlyLight.arrow_down,
                                    Yellow1,
                                    "Unduh Rekap",
                                    getTextBtnAction(context), () {
                                  if (textC.datepickerKey.value.currentState!
                                          .validate() &&
                                      cDropdown.pinRekapKey.value.currentState!
                                          .validate()) {
                                    controller
                                        .unduhPDF(cDropdown.pinRekapC.text);
                                  }
                                }),
                                SizedBox(
                                  height: 4.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      controller.isClicked.value == false
                          ? SizedBox(
                              width: 90.w,
                              height: 70.h,
                              child: FutureBuilder<List<KepegawaianModel>>(
                                  future: controller.firestoreKepegawaianList,
                                  builder: (context, snap) {
                                    if (!snap.hasData) {
                                      return const LoadingView();
                                    }
                                    final kepegawaianList =
                                        snap.data! as List<KepegawaianModel>;

                                    return ResponsiveGridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        alignment: Alignment.center,
                                        gridDelegate: ResponsiveGridDelegate(
                                            crossAxisExtent: 32.5.h,
                                            mainAxisSpacing: 2.h,
                                            crossAxisSpacing: 2.w,
                                            childAspectRatio: 1.5),
                                        itemCount: kepegawaianList.length,
                                        itemBuilder: (context, index) {
                                          kepegawaianList.sort((a, b) =>
                                              a.pin!.compareTo(b.pin!));
                                          var data = kepegawaianList[index];

                                          return itemListRiwayatPresensi(() {
                                            Get.toNamed(Routes.DETAIL_PRESENSI,
                                                arguments: data.pin!);
                                          }, data.nama!, data.pin!,
                                              data.bidang!);
                                        });
                                  }),
                            )
                          : controller.pdfURL.value != ''
                              ? SizedBox(
                                  width: 90.w,
                                  height: 70.h,
                                  child: SafeArea(
                                    child: Obx(
                                      () => SfPdfViewer.network(
                                        controller.pdfURL.value,
                                      ),
                                    ),
                                  ))
                              : SizedBox(
                                  width: 90.w,
                                  height: 70.h,
                                  child: Center(
                                      child: Lottie.asset(
                                          'assets/lootie/loading2.json',
                                          height: 135))),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
