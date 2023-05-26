import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/rekap_scanlog_per_controller.dart';

class RekapScanlogPerView extends GetView<RekapScanlogPerController> {
  const RekapScanlogPerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final controller = Get.put(RekapScanlogPerController());
    cDropdown.pinRekapC.clear();
    textC.datepickerC.clear();
    return Scaffold(
      backgroundColor: light,
      drawer: const NavigationDrawerView(),
      drawerScrimColor: light.withOpacity(0.6),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
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
                      icon: Icon(IconlyLight.logout),
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
            padding:
                EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w, bottom: 8.h),
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
                          'November 2022',
                          style: getTextSubHeader(context),
                        ),
                        Text(
                          ' / ',
                          style: getTextSubHeader(context),
                        ),
                        Text(
                          'Februari 2023',
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
                      dropdownNormalField2(
                          context,
                          16.w,
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
                          'Pilih PIN Pegawai',
                          Colors.transparent,
                          dark,
                          Blue1,
                          cDropdown.pinRekapC.text == ''
                              ? null
                              : cDropdown.pinRekapC.text),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      textformDatePicker(
                          controller.end.value.isAtSameMomentAs(DateTime.now())
                              ? TextEditingController(text: '')
                              : textC.datepickerC, () {
                        Get.dialog(
                          Dialog(
                            child: Container(
                              padding: EdgeInsets.all(1.h),
                              height: 40.h,
                              width: 20.w,
                              // color: light,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: SfDateRangePicker(
                                todayHighlightColor: Blue1,
                                selectionColor: Blue1,
                                rangeSelectionColor: Blue1.withOpacity(0.2),
                                startRangeSelectionColor:
                                    Blue1.withOpacity(0.5),
                                endRangeSelectionColor: Blue1.withOpacity(0.5),
                                monthViewSettings:
                                    DateRangePickerMonthViewSettings(
                                  firstDayOfWeek: 1,
                                ),
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                showActionButtons: true,
                                cancelText: "Batal",
                                confirmText: "OK",
                                onCancel: () => Get.back(),
                                onSubmit: (value) {
                                  if (value != null) {
                                    if ((value as PickerDateRange).endDate !=
                                        null) {
                                      controller.pickRangeDate(
                                          value.startDate!, value.endDate!);
                                      Get.back();
                                    } else {
                                      Get.defaultDialog(
                                          title: 'Terjadi Kesalahan',
                                          middleText:
                                              'Pilih tanggal jangkauan\n(Senin-Sabtu, dsb)\n(tekan tanggal dua kali \nuntuk memilih tanggal yang sama)');
                                    }
                                  } else {
                                    Get.defaultDialog(
                                        title: 'Terjadi Kesalahan',
                                        middleText: 'Tanggal tidak dipilih');
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      btnDefaultIcon1(13.w, Blue1, IconlyLight.swap, Yellow1,
                          "Preview Rekap", getTextBtnAction(context), () {
                        if (textC.datepickerKey.value.currentState!
                                .validate() &&
                            cDropdown.pinRekapKey.value.currentState!
                                .validate()) {
                          controller.previewPDF(cDropdown.pinRekapC.text);
                        }
                      }),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      btnDefaultIcon1(13.w, Blue1, IconlyLight.swap, Yellow1,
                          "Unduh Rekap", getTextBtnAction(context), () {
                        if (textC.datepickerKey.value.currentState!
                                .validate() &&
                            cDropdown.pinRekapKey.value.currentState!
                                .validate()) {
                          controller.unduhPDF(cDropdown.pinRekapC.text);
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                controller.isClicked.value == false
                    ? Container(
                        decoration:
                            BoxDecoration(color: Blue1.withOpacity(0.2)),
                        width: 90.w,
                        height: 70.h,
                        child: StreamBuilder<List<KepegawaianModel>>(
                            stream: controller.firestoreKepegawaianList,
                            builder: (context, snap) {
                              final kepegawaianList =
                                  snap.data!.obs as List<KepegawaianModel>;
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
                                        subtitle: Text(data.pin!),
                                      ),
                                    );
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
                              child: CircularProgressIndicator(
                                color: Blue1,
                              ),
                            )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
