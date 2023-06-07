import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controller/api_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/datePicker.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/textfield.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/rekap_presensi_all_controller.dart';

class RekapPresensiAllView extends GetView<RekapPresensiAllController> {
  const RekapPresensiAllView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final controller = Get.put(RekapPresensiAllController());
    final dateFormatter = DateFormat('MMMM yyyy', 'id-ID');
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
                    'Rekapitulasi Presensi Semua Pegawai',
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
                            : dateFormatter.format(controller.end.value),
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
                              DateRangePickerSelectionMode.range, (value) {
                            if (value != null) {
                              if ((value as PickerDateRange).endDate != null) {
                                controller.pickRangeDate(
                                    value.startDate!, value.endDate!);
                                Get.back();
                              } else {
                                Get.dialog(dialogAlertOnly(
                                    IconlyLight.danger,
                                    "Terjadi Kesalahan.",
                                    "Pilih tanggal jangkauan\n(Senin-Sabtu, dsb)\n(tekan tanggal dua kali \nuntuk memilih tanggal yang sama)",
                                    getTextAlert(context),
                                    getTextAlertSub(context)));
                              }
                            } else {
                              Get.dialog(dialogAlertOnly(
                                  IconlyLight.danger,
                                  "Terjadi Kesalahan.",
                                  "Tanggal tidak dipilih.",
                                  getTextAlert(context),
                                  getTextAlertSub(context)));
                            }
                          }, null, null));
                        }, 24.w, light, Blue1, dark, Blue1,
                            getTextFormDialog2(Get.context!), null),
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
                              .validate()) {
                            // controller.previewPDF(cDropdown.pinRekapC.text);
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
                              .validate()) {
                            // controller.unduhPDF(cDropdown.pinRekapC.text);
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
