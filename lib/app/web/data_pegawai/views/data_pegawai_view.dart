import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/dialogTextField.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/kepegawaianDTS.dart';
import '../../../utils/loading.dart';
import '../../../utils/session.dart';
import '../../../utils/textfield.dart';
import '../../navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/data_pegawai_controller.dart';

class DataPegawaiView extends GetView<DataPegawaiController> {
  const DataPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final c = Get.put(DataPegawaiController());
    StorageService.saveCurrentRoute(Routes.DATA_PEGAWAI);
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
                    'Data Kepegawaian',
                    style: getTextHeader2(context),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    btnDefaultIcon1(15.w, Blue1, IconlyLight.plus, Yellow1,
                        "Tambah Data", getTextBtnAction(context), () {
                      textC.namaTambahDataPegC.clear();
                      textC.pinTambahDataPegC.clear();
                      cDropdown.kepgTambahDataPegC.clear();
                      textC.nipTambahDataPegC.clear();
                      cDropdown.bidangTambahDataPegC.clear();

                      Get.dialog(
                          dialogTextFieldSevenField(
                              context,
                              btnDefaultIcon1(
                                  10.w,
                                  Blue4,
                                  IconlyLight.tick_square,
                                  Yellow1,
                                  "Kirim",
                                  getTextBtnAction(context), () {
                                if (textC.namaTambahDataPegKey.value
                                        .currentState!
                                        .validate() &&
                                    textC
                                        .pinTambahDataPegKey.value.currentState!
                                        .validate() &&
                                    cDropdown.kepgTambahDataPegKey.value
                                        .currentState!
                                        .validate() &&
                                    textC
                                        .nipTambahDataPegKey.value.currentState!
                                        .validate() &&
                                    cDropdown.bidangTambahDataPegKey.value
                                        .currentState!
                                        .validate()) {
                                  c.addPegawai(
                                    context,
                                    textC.namaTambahDataPegC.text,
                                    textC.pinTambahDataPegC.text,
                                    cDropdown.kepgTambahDataPegC.text,
                                    textC.nipTambahDataPegC.text,
                                    cDropdown.bidangTambahDataPegC.text,
                                  );
                                }
                              }),
                              false),
                          barrierColor: light.withOpacity(0.7));
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
                    stream: c.firestoreKepegawaianList,
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return const LoadingView();
                      }
                      final kepegawaianList =
                          snap.data! as List<KepegawaianModel>;
                      int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

                      return GetBuilder<DataPegawaiController>(builder: (c) {
                        return PaginatedDataTable2(
                          sortColumnIndex: c.sortColumnIndex.value,
                          sortAscending: c.sortAscending.value,
                          sortArrowIcon:
                              Icons.keyboard_arrow_up, // custom arrow
                          sortArrowAnimationDuration:
                              const Duration(milliseconds: 0),
                          columns: [
                            DataColumn2(
                              onSort: (columnIndex, ascending) {
                                c.sortData(columnIndex, ascending);
                              },
                              label: Text(
                                'PIN',
                                style: getTextTable(context),
                              ),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              onSort: (columnIndex, ascending) {
                                c.sortData(columnIndex, ascending);
                              },
                              label: Text(
                                'NIP',
                                style: getTextTable(context),
                              ),
                            ),
                            DataColumn2(
                              onSort: (columnIndex, ascending) {
                                c.sortData(columnIndex, ascending);
                              },
                              label: Text(
                                'Nama',
                                style: getTextTable(context),
                              ),
                            ),
                            DataColumn2(
                                onSort: (columnIndex, ascending) {
                                  c.sortData(columnIndex, ascending);
                                },
                                label: Text(
                                  'Kepegawaian',
                                  style: getTextTable(context),
                                )),
                            DataColumn2(
                                onSort: (columnIndex, ascending) {
                                  c.sortData(columnIndex, ascending);
                                },
                                label: Text(
                                  'Bidang',
                                  style: getTextTable(context),
                                )),
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
                          source: KepegawaianDTS(kepegawaianList),
                          onRowsPerPageChanged: (value) {
                            rowsPerPage = value!;
                          },
                          initialFirstRowIndex: 0,
                          rowsPerPage: rowsPerPage,
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
