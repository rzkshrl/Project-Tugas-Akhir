import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:monitorpresensi/app/data/models/usermodel.dart';
import 'package:monitorpresensi/app/utils/userDTS.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/dialogTextField.dart';
import '../../../utils/dropdownTextField.dart';
import '../../../utils/loading.dart';
import '../../../utils/session.dart';
import '../../../utils/textfield.dart';

import '../../../utils/userDisabledDTS.dart';
import '../controllers/super_admin_controller.dart';

class SuperAdminView extends GetView<SuperAdminController> {
  const SuperAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final c = Get.put(SuperAdminController());
    StorageService.saveCurrentRoute(Routes.SUPER_ADMIN);
    return FutureBuilder(
        future: simulateDelay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan LoadingWidget selama delay
            return const LoadingView();
          }
          return Scaffold(
            backgroundColor: light,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                          'Data User',
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
                              13.w,
                              Blue1,
                              IconlyLight.plus,
                              Yellow1,
                              "Tambah Data",
                              getTextBtnAction(context), () {
                            textC.namaDataUserC.clear();
                            cDropdown.roleDataUserC.clear();
                            cDropdown.jabatanDataUserC.clear();
                            textC.emailDataUserC.clear();
                            textC.passDataUserC.clear();
                            textC.pinDataUserC.clear();
                            Get.dialog(
                                dialogTextFieldDataUser(
                                    context,
                                    btnDefaultIcon1(
                                        10.w,
                                        Blue4,
                                        IconlyLight.tick_square,
                                        Yellow1,
                                        "Kirim",
                                        getTextBtnAction(context), () {
                                      if (textC.namaDataUserKey.value
                                              .currentState!
                                              .validate() &&
                                          cDropdown.roleDataUserKey.value.currentState!
                                              .validate() &&
                                          cDropdown.jabatanDataUserKey.value
                                              .currentState!
                                              .validate() &&
                                          textC.emailDataUserKey.value
                                              .currentState!
                                              .validate() &&
                                          textC.passDataUserKey.value
                                              .currentState!
                                              .validate() &&
                                          textC.pinDataUserKey.value
                                              .currentState!
                                              .validate()) {
                                        c.addUser(
                                            textC.namaDataUserC.text,
                                            cDropdown.roleDataUserC.text,
                                            cDropdown.jabatanDataUserC.text,
                                            textC.emailDataUserC.text,
                                            textC.passDataUserC.text,
                                            textC.pinDataUserC.text);
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
                    Center(
                      child: Text(
                        'User Aktif',
                        style: getTextHeader(context),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Blue1.withOpacity(0.2)),
                      width: 90.w,
                      height: 40.h,
                      child: StreamBuilder(
                          stream: c.firestoreUserList,
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return const LoadingView();
                            }
                            final userList = snap.data! as List<UserModel>;

                            int rowsPerPage =
                                PaginatedDataTable.defaultRowsPerPage;
                            return GetBuilder<SuperAdminController>(
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
                                      'Nama',
                                      style: getTextTable(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      'Role',
                                      style: getTextTable(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      'Jabatan',
                                      style: getTextTable(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      'Email',
                                      style: getTextTable(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                      label: Text(
                                        'Non-aktifkan',
                                        style: getTextTable(context),
                                      ),
                                      fixedWidth: 125),
                                ],
                                dividerThickness: 0,
                                horizontalMargin: 20,
                                checkboxHorizontalMargin: 12,
                                columnSpacing: 20,
                                wrapInCard: false,
                                minWidth: 950,
                                renderEmptyRowsInTheEnd: false,
                                source: UserDTS(userList),
                                onRowsPerPageChanged: (value) {
                                  rowsPerPage = value!;
                                },
                                initialFirstRowIndex: 0,
                                rowsPerPage: rowsPerPage,
                              );
                            });
                          }),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: Text(
                        'User Nonaktif',
                        style: getTextHeaderDisabled(context),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Blue1.withOpacity(0.2)),
                      width: 90.w,
                      height: 40.h,
                      child: StreamBuilder(
                          stream: c.firestoreUserDisabledList,
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return const LoadingView();
                            }
                            final userDisabledList =
                                snap.data! as List<UserModel>;

                            int rowsPerPage =
                                PaginatedDataTable.defaultRowsPerPage;
                            return GetBuilder<SuperAdminController>(
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
                                      'Nama',
                                      style: getTextTableDisabled(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      'Role',
                                      style: getTextTableDisabled(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      'Jabatan',
                                      style: getTextTableDisabled(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      'Email',
                                      style: getTextTableDisabled(context),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      c.sortData(columnIndex, ascending);
                                    },
                                  ),
                                  DataColumn2(
                                      label: Text(
                                        'Aktifkan',
                                        style: getTextTableDisabled(context),
                                      ),
                                      fixedWidth: 125),
                                ],
                                dividerThickness: 0,
                                horizontalMargin: 20,
                                checkboxHorizontalMargin: 12,
                                columnSpacing: 20,
                                wrapInCard: false,
                                minWidth: 950,
                                renderEmptyRowsInTheEnd: false,
                                source: UserDisabledDTS(userDisabledList),
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
        });
  }
}
