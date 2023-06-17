// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import 'package:monitorpresensi/app/data/models/usermodel.dart';
import 'package:monitorpresensi/app/web/super-admin/controllers/super_admin_controller.dart';
import 'package:monitorpresensi/app/theme/theme.dart';
import 'package:monitorpresensi/app/utils/stringGlobal.dart';

import '../theme/textstyle.dart';

class UserDTS extends DataTableSource {
  final List<UserModel> userList;

  final c = Get.put(SuperAdminController());

  UserDTS(this.userList);

  int sortColumnIndex = 0;
  bool sortAscending = true;

  void sortData() {
    userList.sort((a, b) {
      int result = 0;
      switch (c.sortColumnIndex.value) {
        case 0:
          result = a.name!.compareTo(b.name!);
          break;
        case 1:
          result = a.role!.compareTo(b.role!);
          break;
        case 2:
          result = a.bidang!.compareTo(b.bidang!);
          break;
        case 3:
          result = a.email!.compareTo(b.email!);
          break;
      }
      return c.sortAscending.value ? result : -result;
    });
  }

  @override
  DataRow getRow(int index) {
    sortData();
    UserModel data = userList[index];

    return DataRow(
      cells: [
        DataCell(Text(
          data.name!,
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          // "${data.role}",
          data.role == superAdmin
              ? "Super-Admin"
              : data.role == admin
                  ? "Admin"
                  : "Pegawai",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.bidang}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.email}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {
              c.deleteDoc(data.email!, data.uid!);
            },
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userList.length;

  @override
  int get selectedRowCount => 0;
}
