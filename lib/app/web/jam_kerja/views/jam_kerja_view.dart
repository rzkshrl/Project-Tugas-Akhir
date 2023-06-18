import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:monitorpresensi/app/utils/dialogTextField.dart';
import 'package:monitorpresensi/app/utils/jamKerjaDTS.dart';
import 'package:monitorpresensi/app/utils/loading.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/firestorejamkerjamodel.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';

import '../../../utils/btnDefault.dart';
import '../../../utils/dropdownTextField.dart';
import '../../../utils/session.dart';
import '../../../utils/textfield.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/jam_kerja_controller.dart';

class JamKerjaView extends GetView<JamKerjaController> {
  const JamKerjaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    StorageService.saveCurrentRoute(Routes.JAM_KERJA);
    final c = Get.put(JamKerjaController());
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
                          'Jam Kerja',
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
                              15.w,
                              Blue1,
                              IconlyLight.plus,
                              Yellow1,
                              "Tambah Data",
                              getTextBtnAction(context), () {
                            textC.namaJamKerjaC.clear();
                            cDropdown.kepgTambahDataPegC.clear();
                            textC.ketJamKerjaC.clear();
                            textC.masukJamKerjaC.clear();
                            textC.keluarJamKerjaC.clear();
                            textC.batasAwalmasukJamKerjaC.clear();
                            textC.batasAkhirmasukJamKerjaC.clear();
                            textC.batasAwalkeluarJamKerjaC.clear();
                            textC.batasAkhirkeluarJamKerjaC.clear();
                            textC.terlambatJamKerjaC.clear();
                            textC.pulLebihAwalJamKerjaC.clear();
                            Get.dialog(dialogTextJamKerja(
                                false,
                                context,
                                btnDefaultIcon1(
                                    10.w,
                                    Blue4,
                                    IconlyLight.tick_square,
                                    Yellow1,
                                    "Kirim",
                                    getTextBtnAction(context), () {
                                  if (textC.namaJamKerjaKey.value.currentState!
                                          .validate() &&
                                      cDropdown.kepgTambahDataPegKey.value
                                          .currentState!
                                          .validate() &&
                                      textC.ketJamKerjaKey.value.currentState!
                                          .validate() &&
                                      textC.masukJamKerjaKey.value.currentState!
                                          .validate() &&
                                      textC.keluarJamKerjaKey.value.currentState!
                                          .validate() &&
                                      textC.batasAwalmasukJamKerjaKey.value
                                          .currentState!
                                          .validate() &&
                                      textC.batasAkhirmasukJamKerjaKey.value
                                          .currentState!
                                          .validate() &&
                                      textC.batasAwalkeluarJamKerjaKey.value
                                          .currentState!
                                          .validate() &&
                                      textC.batasAkhirkeluarJamKerjaKey.value
                                          .currentState!
                                          .validate() &&
                                      textC.terlambatJamKerjaKey.value
                                          .currentState!
                                          .validate() &&
                                      textC.pulLebihAwalJamKerjaKey.value
                                          .currentState!
                                          .validate()) {
                                    c.addJamKerja(
                                        textC.namaJamKerjaC.text,
                                        cDropdown.kepgTambahDataPegC.text,
                                        textC.ketJamKerjaC.text,
                                        textC.masukJamKerjaC.text,
                                        textC.keluarJamKerjaC.text,
                                        textC.batasAwalmasukJamKerjaC.text,
                                        textC.batasAwalkeluarJamKerjaC.text,
                                        textC.batasAkhirmasukJamKerjaC.text,
                                        textC.batasAkhirkeluarJamKerjaC.text,
                                        textC.terlambatJamKerjaC.text,
                                        textC.pulLebihAwalJamKerjaC.text);
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
                      child: StreamBuilder(
                          stream: c.firestoreJamKerjaList,
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return const LoadingView();
                            }
                            final jamKerjaList =
                                snap.data! as List<JamKerjaModel>;
                            if (jamKerjaList.isEmpty) {
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
                            return GetBuilder<JamKerjaController>(builder: (c) {
                              return PaginatedDataTable2(
                                  sortColumnIndex: c.sortColumnIndex.value,
                                  sortAscending: c.sortAscending.value,
                                  sortArrowIcon: Icons.keyboard_arrow_up,
                                  sortArrowAnimationDuration:
                                      const Duration(milliseconds: 0),
                                  columns: [
                                    DataColumn2(
                                      label: Text(
                                        'Nama',
                                        style: getTextTable(context),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        c.sortData(columnIndex, ascending);
                                      },
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Hari',
                                        style: getTextTable(context),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        c.sortData(columnIndex, ascending);
                                      },
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Jam Masuk',
                                        style: getTextTable(context),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        c.sortData(columnIndex, ascending);
                                      },
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Jam Keluar',
                                        style: getTextTable(context),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        c.sortData(columnIndex, ascending);
                                      },
                                      size: ColumnSize.S,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Keterlambatan',
                                        style: getTextTable(context),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        c.sortData(columnIndex, ascending);
                                      },
                                      size: ColumnSize.M,
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        'Pulang Lebih Awal',
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
                                        fixedWidth: 90),
                                    DataColumn2(
                                        label: Text(
                                          'Ubah',
                                          style: getTextTable(context),
                                        ),
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
                                  source: JamKerjaDTS(jamKerjaList));
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
