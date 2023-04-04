import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/firestorescanlogmodel.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';

import '../theme/textstyle.dart';

class KepegawaianDTS extends DataTableSource {
  final List<KepegawaianModel> kepegawaianList;

  KepegawaianDTS(this.kepegawaianList);

  @override
  DataRow getRow(int index) {
    KepegawaianModel data = kepegawaianList[index];
    return DataRow(
      cells: [
        DataCell(Text(
          data != null ? "${data.pin}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.nip}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.nama}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.jadker}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.email}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.bidang}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
        DataCell(IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.edit,
              color: Blue1,
            ))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => kepegawaianList.length;

  @override
  int get selectedRowCount => 0;
}
