import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/firestorescanlogmodel.dart';

class KepegawaianDTS extends DataTableSource {
  final List<KepegawaianModel> kepegawaianList;

  KepegawaianDTS(this.kepegawaianList);

  @override
  DataRow2? getRow(int index) {
    @override
    DataRow getRow(int index) {
      KepegawaianModel data = kepegawaianList[index];
      return DataRow(
        cells: [
          DataCell(Text(data != null ? "${data.pin}" : "-")),
          DataCell(Text(data != null ? "${data.nip}" : "-")),
          DataCell(Text(data != null ? "${data.nama}" : "-")),
          DataCell(Text(data != null ? "${data.email}" : "-")),
          DataCell(Text(data != null ? "${data.bidang}" : "-")),
          DataCell(
              IconButton(onPressed: () {}, icon: Icon(IconlyLight.delete))),
          DataCell(IconButton(onPressed: () {}, icon: Icon(IconlyLight.edit))),
        ],
      );
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => kepegawaianList.length;

  @override
  int get selectedRowCount => 0;
}
