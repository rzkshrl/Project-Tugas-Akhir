import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:project_tugas_akhir/app/data/models/firestorehariliburmodel.dart';

import 'package:project_tugas_akhir/app/utils/dialogTextField.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/api_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/holidayDTS.dart';
import '../../../utils/loading.dart';
import '../../../utils/session.dart';
import '../../../utils/textfield.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/hari_libur_controller.dart';

class HariLiburView extends GetView<HariLiburController> {
  const HariLiburView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final c = Get.put(HariLiburController());
    final apiC = Get.put(APIController(context1: context));
    StorageService.saveCurrentRoute(Routes.HARI_LIBUR);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hari Libur/Cuti Bersama',
                          style: getTextHeader2(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 1.8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          btnDefaultIcon1(
                              18.w,
                              Blue1,
                              FontAwesomeIcons.rotate,
                              Yellow1,
                              "Sinkron Hari Libur",
                              getTextBtnAction(context), () {
                            Get.dialog(dialogAPILibur(
                                context,
                                btnDefaultIcon1(
                                    10.w,
                                    Blue4,
                                    IconlyLight.tick_square,
                                    Yellow1,
                                    "Kirim",
                                    getTextBtnAction(context), () {
                                  if (textC.yearAPILiburKey.value.currentState!
                                      .validate()) {
                                    apiC.getLiburData(textC.yearAPILiburC.text);
                                  }
                                })));
                          }),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          btnDefaultIcon1(
                              18.w,
                              Blue1,
                              IconlyLight.plus,
                              Yellow1,
                              "Tambah Hari Libur",
                              getTextBtnAction(context), () {
                            textC.addNamaLiburC.clear();
                            textC.datepickerC.clear();
                            Get.dialog(
                              dialogAddLibur(
                                  context,
                                  btnDefaultIcon1(
                                      10.w,
                                      Blue4,
                                      IconlyLight.tick_square,
                                      Yellow1,
                                      "Kirim",
                                      getTextBtnAction(context), () {
                                    if (textC
                                            .addNamaLiburKey.value.currentState!
                                            .validate() &&
                                        textC.datepickerKey.value.currentState!
                                            .validate()) {
                                      controller.addHariLibur(
                                          textC.addNamaLiburC.text,
                                          textC.datepickerC.text);
                                    }
                                  })),
                            );
                          })
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
                      child: FutureBuilder(
                          future: c.firestoreHolidayList,
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return const LoadingView();
                            }
                            final holidayList =
                                snap.data! as List<HolidayModel>;
                            if (holidayList.isEmpty) {
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
                            int rowsPerPage =
                                PaginatedDataTable.defaultRowsPerPage;
                            return GetBuilder<HariLiburController>(
                                builder: (c) {
                              return PaginatedDataTable2(
                                  sortColumnIndex: c.sortColumnIndex.value,
                                  sortAscending: c.sortAscending.value,
                                  sortArrowIcon: Icons.keyboard_arrow_up,
                                  sortArrowAnimationDuration:
                                      const Duration(milliseconds: 0),
                                  columns: [
                                    DataColumn2(
                                      label: Text(
                                        'Nama Hari Libur/Cuti Bersama',
                                        style: getTextTable(context),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        c.sortData(columnIndex, ascending);
                                      },
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Tanggal',
                                        style: getTextTable(context),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        c.sortData(columnIndex, ascending);
                                      },
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                        label: Text(
                                          'Hapus',
                                          style: getTextTable(context),
                                        ),
                                        onSort: (columnIndex, ascending) {
                                          c.sortData(columnIndex, ascending);
                                        },
                                        fixedWidth: 90),
                                    DataColumn2(
                                        label: Text(
                                          'Ubah',
                                          style: getTextTable(context),
                                        ),
                                        onSort: (columnIndex, ascending) {
                                          c.sortData(columnIndex, ascending);
                                        },
                                        fixedWidth: 90),
                                  ],
                                  dividerThickness: 0,
                                  horizontalMargin: 20,
                                  checkboxHorizontalMargin: 12,
                                  columnSpacing: 20,
                                  wrapInCard: false,
                                  minWidth: 950,
                                  renderEmptyRowsInTheEnd: false,
                                  onRowsPerPageChanged: (value) {
                                    rowsPerPage = value!;
                                  },
                                  initialFirstRowIndex: 0,
                                  rowsPerPage: rowsPerPage,
                                  source: HolidayDTS(holidayList));
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
